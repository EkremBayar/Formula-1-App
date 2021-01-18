# Packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(openxlsx)



# Tyres Summary -----------------------------------------------------------

# url <- "https://www.f1cfa.com/f1-tyres-statistics.asp?t=2020&gpn=All&tipo=All&driver=All"
# tyres <- read_html(url)
# tyres <- tyres%>% html_table(fill = T)
# 
# write.csv(tyres, "data/tyres.csv")

tyres <- read.csv("data/tyres.csv") %>% 
  select(-X) %>% rename("#Laps" = X.Laps) %>% 
  mutate(Tyres = str_replace_all(Tyres,"Lluvia Extrema Usado", "Wet Used"))




# Teams -------------------------------------------------------------------

team <- read.xlsx("data/teams.xlsx")

# Color -------------------------------------------------------------------

color <- read.csv("data/color.csv", sep = ";")


# Import all data from Kaggle dataset -------------------------------------

circuits <- read.csv("data/circuits.csv")
constructor_results <- read.csv("data/constructor_results.csv")
constructor_standings <- read.csv("data/constructor_standings.csv")
constructors <- read.csv("data/constructors.csv")
driver_standings <- read.csv("data/driver_standings.csv")
drivers <- read.csv("data/drivers.csv")
lap_times = read.csv("data/lap_times.csv")
pit_stops = read.csv("data/pit_stops.csv")
qualifying = read.csv("data/qualifying.csv")
races = read.csv("data/races.csv")
results = read.csv("data/results.csv")
seasons = read.csv("data/seasons.csv")
status = read.csv("data/status.csv")

drivers_info <- read.csv("data/drivers_info.csv", sep = ";")


# Subset:2020 -------------------------------------------------------------

races <- races %>% filter(year == 2020) %>% rename(circuit = name)
f1_2020 <- races$raceId

cons <- constructor_results %>% 
  filter(raceId %in% f1_2020) %>% 
  pull(constructorId) %>% unique()



# Highlights --------------------------------------------------------------
all_highlights <- list.files("www/highlights")
all_highlights <- data.frame(
  img = all_highlights,
  type = as.character(case_when(
    str_detect(all_highlights, "Race") ~ "Race",
    str_detect(all_highlights, "Qualifying") ~ "Qualifying",
    TRUE ~ "Practice"
  ))
)
all_highlights$short <- sapply(str_split(all_highlights$img, " "), function(x){x[1]})
temp_races <- races
temp_races$short <- sapply(str_split(temp_races$circuit, " "), function(x){x[1]})
all_highlights <- left_join(all_highlights, temp_races %>% select(round, short)) %>% select(-short) %>% 
  arrange(round, type)
rm(temp_races)
all_highlights$name <- sapply(str_split(all_highlights$img, "-"), function(x){x[1]})
all_highlights$race_type <- str_trim(str_remove_all(sapply(str_split(all_highlights$img, "-"), function(x){x[2]}), ".webp"))

highlights <- read.xlsx("data/highlights.xlsx") %>% 
  separate(race, c("name", "race_type"), sep = ": ")

all_highlights <- left_join(all_highlights, highlights)



# Data Manipulation -------------------------------------------------------




# Circuits
circuits <- circuits %>%  select(-circuitId, -alt, -circuitRef)


# Drivers
drivers <- drivers %>% 
  unite(driver.name, c("forename", "surname"), sep = " ") %>% 
  select(driverId, code, number, driver.name, dob, nationality, url) %>% 
  rename(driver.number = number)


# Constructors
constructors <- constructors %>% 
  filter(constructorId %in% cons) %>% 
  select(constructorId, name, nationality, url) %>% 
  rename(cons.name=name, cons.nationality = nationality, cons.url = url) 


# Constructors Results: Each Race
constructor_results <- constructor_results %>% 
  filter(raceId %in% f1_2020, constructorId %in% cons) %>% 
  left_join(constructors) %>% 
  left_join(races %>% select(raceId, round, circuit, date), by = "raceId") %>% 
  select(-status, -raceId, -cons.url, -cons.nationality, -constructorId, -constructorResultsId) %>% 
  arrange(round, -points) %>% 
  left_join(color %>% select(-driver.name) %>% distinct())


# Constructors Standing: Cumulative
constructor_standings <- constructor_standings%>% 
  filter(raceId %in% f1_2020, constructorId %in% cons) %>% 
  left_join(constructors) %>% 
  left_join(races %>% select(raceId, round, circuit, date), by = "raceId") %>% 
  select(-raceId, -constructorId, -constructorStandingsId, -positionText,-cons.nationality, -cons.url) %>% 
  arrange(round, -points) %>% 
  left_join(color %>% select(-driver.name) %>% distinct())


# Driver Standing
driver_standings <- driver_standings%>% 
  filter(raceId %in% f1_2020) %>% 
  left_join(drivers) %>% 
  left_join(races %>% select(raceId, round, circuit, date)) %>% 
  select(-driverStandingsId,-driverId, -raceId, -dob, -url, -nationality, -positionText) %>% 
  filter(!driver.name %in% c("Pietro Fittipaldi", "Jack Aitken", "Nico Hülkenberg")) %>% 
  arrange(round, -points) %>% 
  left_join(color %>% select(-cons.name))


# Lap Times
lap_times <- lap_times %>% 
  filter(raceId %in% f1_2020) %>% 
  left_join(drivers) %>% 
  left_join(races %>% select(raceId, round, circuit, date) , by = "raceId") %>% 
  select(-driverId, -raceId, -dob, -url, -nationality) %>% 
  arrange(round, code, lap) %>% 
  left_join(color %>% select(-cons.name))


# Pit Stops # NOT: gganimate ile pit stop yapabilir misin?
pit_stops <- pit_stops %>% 
  filter(raceId %in% f1_2020) %>% 
  left_join(drivers) %>% 
  left_join(races %>% select(raceId, round, circuit, date), by = "raceId") %>% 
  select(-driverId, -raceId, -dob, -url, -nationality) %>% 
  left_join(color %>% select(-cons.name))


# Qualifying
qualifying <- qualifying %>% 
  filter(raceId %in% f1_2020) %>% 
  left_join(drivers) %>% 
  left_join(races %>% select(raceId, round, circuit, date), by = "raceId") %>% 
  left_join(constructors, by = "constructorId") %>% 
  select(-driverId, -raceId, -number, -qualifyId, -constructorId,-dob, -url, -nationality, -cons.url, -cons.nationality) %>% 
  left_join(color %>% select(-driver.name) %>% distinct())

drivers <- drivers %>% 
  filter(!driver.name %in% c("Pietro Fittipaldi", "Jack Aitken", "Nico Hülkenberg")) %>% 
  mutate(driver.name = as.character(driver.name)) %>% 
  inner_join((color %>% mutate(new = paste0(driver.name, "-", cons.name)) %>% 
                filter(new != "George Russell-Mercedes") %>% select(-new)))







library(ggimage)
library(gganimate)

driver_standings %>% 
  inner_join(drivers %>% select(driver.name, cons.name))%>% 
  filter(!driver.name %in% c("Pietro Fittipaldi", "Jack Aitken")) %>% 
  mutate(cars = paste0("www/cars/",cons.name, ".png")) %>% 
  ggplot()+
  
  geom_hline(aes(yintercept = 0),color = "white")+
  geom_hline(aes(yintercept = 150),color = "white")+
  geom_hline(aes(yintercept = 300),color = "white")+
  
  geom_image(aes(x = reorder(driver.name, points), y = points, image = cars, group = position),size = 0.2)+
  geom_text(aes(x = reorder(driver.name, points), y = -50, label = driver.name, group = position), 
            hjust = 1.15 ,color = "white", family = "Formula1 Display-Regular")+
  
  
  
  coord_flip()+
  theme(
    axis.ticks = element_blank(),
    axis.text.x = element_text(color = "white", family = "Formula1 Display-Regular"),
    axis.text.y = element_blank(),
    plot.background = element_rect(fill = "#535152", color = "#535152"),
    panel.background = element_rect(fill = "#535152", color = "#535152"),
    # panel.grid.major.y = element_blank(),
    # panel.grid.minor.y = element_blank(),
    # panel.grid.minor.x = element_blank(),
    # panel.grid.major.x = element_blank(),
    #panel.grid = element_line(color = "gray")
    panel.grid = element_blank()
  )+
  labs(x = NULL, y = NULL)+
  facet_wrap(~round)+
  facet_null() + 
  #scale_y_continuous(position = "bottom",label = c("", "0", "100", "200", "300", "400"))+
  ylim(-300,450)

+
  transition_time(round)


library(gganimate)
library(plotly)










tyres %>% 
  separate(Tyres, c("Tyres", "Situation"), sep = " ") %>% 
  group_by(Tyres) %>% 
  count() %>% 
  ggplot(aes(reorder(Tyres, n), n, image = paste0("www/tyres/", Tyres, ".png")))+
  geom_image(size = 0.1)+
  coord_flip()