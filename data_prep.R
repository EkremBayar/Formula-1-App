# Packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(openxlsx)



# Tyres Summary -----------------------------------------------------------

url <- "https://www.f1cfa.com/f1-tyres-statistics.asp?t=2020&gpn=All&tipo=All&driver=All"
tyres <- read_html(url)
tyres <- tyres%>% html_table(fill = T)

write.csv(tyres, "dashboard/data/tyres.csv")

tyres <- read.csv("dashboard/data/tyres.csv") %>% 
  select(-X) %>% rename("#Laps" = X.Laps)


# Color -------------------------------------------------------------------

color <- read.csv("dashboard/data/color.csv", sep = ";")


# Import all data from Kaggle dataset -------------------------------------

circuits <- read.csv("dashboard/data/circuits.csv")
constructor_results <- read.csv("dashboard/data/constructor_results.csv")
constructor_standings <- read.csv("dashboard/data/constructor_standings.csv")
constructors <- read.csv("dashboard/data/constructors.csv")
driver_standings <- read.csv("dashboard/data/driver_standings.csv")
drivers <- read.csv("dashboard/data/drivers.csv")
lap_times = read.csv("dashboard/data/lap_times.csv")
pit_stops = read.csv("dashboard/data/pit_stops.csv")
qualifying = read.csv("dashboard/data/qualifying.csv")
races = read.csv("dashboard/data/races.csv")
results = read.csv("dashboard/data/results.csv")
seasons = read.csv("dashboard/data/seasons.csv")
status = read.csv("dashboard/data/status.csv")


# Subset:2020 -------------------------------------------------------------

races <- races %>% filter(year == 2020) %>% rename(circuit = name)
f1_2020 <- races$raceId

cons <- constructor_results %>% 
  filter(raceId %in% f1_2020) %>% 
  pull(constructorId) %>% unique()



# Highlights --------------------------------------------------------------
all_highlights <- list.files("dashboard/www/highlights")
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

highlights <- read.xlsx("dashboard/data/highlights.xlsx") %>% 
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
  filter(driver.name != "Nico Hülkenberg") %>% 
  mutate(driver.name = as.character(driver.name)) %>% 
  inner_join((color %>% mutate(new = paste0(driver.name, "-", cons.name)) %>% 
                filter(new != "George Russell-Mercedes") %>% select(-new)))




results2 <- results %>% 
  left_join(drivers) %>% 
  filter(raceId %in% f1_2020) %>% 
  left_join(races %>% select(raceId, round, name, date) %>% rename(circuit = name), by = "raceId") %>% 
  left_join(constructors, by = "constructorId") %>% 
  left_join(status) %>% 
  select(-driverId, -raceId, -number, -constructorId, -statusId)