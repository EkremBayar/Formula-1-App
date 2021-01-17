# Library -----------------------------------------------------------------
source("library/library.R")

# Functions ---------------------------------------------------------------
source("functions.R")


# 
data <- data.frame(
  Drivers = c(
    "Alexander Albon", "Max Verstappen", "Carlos Sainz", "Lando Norris",
    "Antonio Giovinazzi", "Kimi Räikkönen", "Lance Stroll", "Sergio Pérez",
    "Charles Leclerc", "Sebastian Vettel",  "Valtteri Bottas", "Lewis Hamilton", 
    "Nicholas Latifi","George Russell", "Kevin Magnussen", "Romain Grosjean",
    "Pierre Gasly", "Daniil Kvyat","Daniel Ricciardo", "Esteban Ocon"
  ),
  Teams = c(rep("Red Bull Racing", 2), rep("McLaren", 2), rep("Alfa Romeo Racing", 2),
            rep("Racing Point", 2), rep("Ferrari", 2), rep("Mercedes", 2), rep("Williams", 2),
            rep("Haas F1 Team", 2), rep("AlphaTauri", 2), rep("Renault", 2)),
  Colors = c(rep("#0600ef",2), rep("#FF8700",2), rep("#960000",2), rep("#F596C8",2),
             rep("#DC0000",2), rep("#00D2BE",2), rep("#0082fa",2), rep("#787878",2),
             rep("#ffffff",2), rep("#FFF500",2))) %>% arrange(Drivers)




# 4. HEADER ---------------------------------------------------------------

header <- dashboardHeaderPlus(title = tags$img(src = "logo/f1_logo.svg", height = '50%', width = '50%'), 
                              enable_rightsidebar = FALSE, titleWidth = 250)


# 5. SIDEBAR --------------------------------------------------------------

sidebar <- tagList(
  sidebarMenu(id="tabs", 
              # Home Background
              uiOutput('style_tag'),
              # Sidebars
              menuItem("Home", tabName = "tab_home", icon = icon("home")),
              menuItem("Formula 1", tabName = "tab_comp", icon = icon("warehouse")),
              menuItem("Drivers", tabName = "tab_drivers", icon = icon("flag-checkered")),
              menuItem("Teams", tabName = "tab_teams", icon = icon("users")),
              menuItem("Grand Prix", tabName = "tab_grand_prix", icon = icon("road")),
              menuItem("Highlights", tabName = "tab_highlights", icon = icon("youtube")),
              menuItem("Developer", tabName = "tab_developer", icon = icon("user"))
  )
)

# 6. BODY -----------------------------------------------------------------

body <- tagList(br(),
                tabItems(
                  # Home
                  source(file.path("ui", "home.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Teams
                  source(file.path("ui", "drivers.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Teams
                  source(file.path("ui", "teams.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Circuits
                  source(file.path("ui", "grand_prix.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Highlights
                  source(file.path("ui", "highlights.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Developer
                  source(file.path("ui", "developer.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  
                  
                  ##################
                  # Comp: Değişecek
                  source(file.path("ui", "comp.R"),  local = TRUE, encoding = "UTF-8" )$value
                  
                )
)




# 7. UI -------------------------------------------------------------------

ui <-  dashboardPagePlus(
  
  title="Formula 1 App", skin = "green",
  
  # Header
  header,
  
  # Sidebar
  dashboardSidebar(
    width = 220,br(), 
    uiOutput("mySidebarUI")
  ),
  
  # Body
  dashboardBody(
    
    # Loading Screen
    # use_waiter(),
    # suppressWarnings(show_waiter_on_load(
    #   color = "white",#logo = "wallpaper/d.gif"
    #    div(style = "color:white;",
    #        br(),br(),br(),br(),
    #        tags$h1("Ready! Set! Go!", style = "color:red; margin-top:100px", align = "bottom"),
    #        tags$img(src="wallpaper/loading2.gif", width="90%"))
    #        )
    #   ),
    
    uiOutput("myBodyUI"),
    
    ############
    # UI HTML: Burayı comple CSS yazabiliriz
    source(file.path("ui", "html.R"),  local = TRUE, encoding = "UTF-8" )$value
    
  ),
  
  source(file.path("ui", "html_footer.R"),  local = TRUE, encoding = "UTF-8" )$value
  
)



# 8. SERVER ---------------------------------------------------------------

server <- function(input, output, session) {
  
  # Session
  session$onSessionEnded(stopApp)
  
  # Render UI
  observe({
    output$mySidebarUI <- renderUI({ sidebar })
    output$myBodyUI <- renderUI({  body })
    
    isolate({updateTabItems(session, "tabs", "tab_home")})
    
  })
  
  # Loading Screen
  # Sys.sleep(5) 
  # suppressWarnings(hide_waiter())
  
  # Background Image
  output$style_tag <- renderUI({
    if(input$tabs=='tab_home'){
      return(tags$head(tags$style(HTML(
        '.content-wrapper {background-image:url("wallpaper/wallpaper2-min.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
      )}else if(input$tabs=='tab_highlights'){
        return(tags$head(tags$style(HTML(
          '.content-wrapper {background-image:url("wallpaper/70-min.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
        )
      }else if(input$tabs=='tab_developer'){
        return(tags$head(tags$style(HTML(
          '.content-wrapper {background-image:url("wallpaper/wallpaper1-min.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
        )
      }
    else{
      return(tags$head(tags$style(HTML(
        '.content-wrapper {background-image:url(); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
      )
    }
  })
  
  
  
  source("server/tooltip.R") # Tooltips for Observe
  source(file.path("server", "observe.R"),  local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "drivers.R"),  local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "teams.R"),  local = TRUE, encoding = "UTF-8")$value
  source(file.path("server", "grand_prix.R"),  local = TRUE, encoding = "UTF-8")$value
  
  
  
  
  
  
  
  
  
  
  
  
  
  output$highlights_post <- renderUI({
    
    temp <- all_highlights %>% filter(name == input$highlights_circuit,  
                                      race_type == input$highlights_type)
    post <- temp %>% pull(img) %>% as.character()
    link <- temp %>% pull(link) %>% as.character()
    
    tags$a(tags$img(src = paste0("highlights/", post)), href=link, target="_blank")
    
  })
  
  output$grand_prix <- renderUI({
    
    tags$img(src = paste0("grand_prix/", input$grand_prix, ".png"), width = "600px")
  })
  
  
  
  output$driver1_img <- renderUI({
    
    driver_image(input$driver1)
    
  })
  
  output$driver2_img <- renderUI({
    
    driver_image(input$driver2)
    
  })
  
  
  
  output$driver1_name <- renderUI({
    
    h2(input$driver1)
  })
  
  output$driver2_name <- renderUI({
    
    h2(input$driver2)
  })
  
  
  output$comp <- renderPlot({
    
    df <- data.frame(
      Driver = c(rep("Lewis Hamilton", 5), rep("Max Verstappen", 5)),
      Var = rep(toupper(c("qualifying", "race", "points", "best race finish" ,"dnf")), 2),
      Value = c(-4,-6,-3,-8,-2, 4, 7,3,9,10))
    
    c1 <- data %>% filter(Drivers == input$driver1) %>% pull(Colors) %>% as.character()
    c2 <- data %>% filter(Drivers == input$driver2) %>% pull(Colors) %>% as.character()
    
    if (length(c2) == 0 | length(c1) == 0) {
      
      return(NULL)
    }
    
    
    ggplot(df, aes(Var, Value, fill = Driver))+
      geom_col(show.legend = FALSE, width = 0.5, color = "#535152", size = 1)+
      geom_text(df %>% filter(Value < 0), mapping = aes(label = abs(Value)), size = 9, color = "white",
                family = "Formula1 Display-Regular",  position = position_fill(vjust = -10))+
      geom_text(df %>% filter(Value > 0), mapping = aes(label = abs(Value)),size = 9, color = "white",
                family = "Formula1 Display-Regular",  position = position_fill(vjust = 12))+
      coord_flip()+
      scale_fill_manual(values = c(c1, c2))+
      theme(
        panel.background = element_rect(fill = "#535152", color = "#535152"),
        plot.background = element_rect("#535152",  color = "#535152"),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank()
      )+
      annotate("text", x = 5.5, y = 0, label = "QUALIFYING", family = "Formula1 Display-Regular", color = "white", size = 6)+
      annotate("text", x = 4.5, y = 0, label = "RACE", family = "Formula1 Display-Regular", color = "white", size = 6)+
      annotate("text", x = 3.5, y = 0, label = "POINTS", family = "Formula1 Display-Regular", color = "white", size = 6)+
      annotate("text", x = 2.5, y = 0, label = "BEST RACE FINISH", family = "Formula1 Display-Regular", color = "white", size = 6)+
      annotate("text", x = 1.5, y = 0, label = "DNF", family = "Formula1 Display-Regular", color = "white", size = 6)
    
    
  })
  
  
  output$race <- renderPlot({
    
    driver_standings %>% 
      inner_join(drivers %>% select(driver.name, cons.name))%>% 
      filter(!driver.name %in% c("Pietro Fittipaldi", "Jack Aitken")) %>% 
      filter(round == input$r) %>% 
      mutate(cars = paste0("www/cars/",cons.name, ".png")) %>% 
      ggplot()+
      
      geom_hline(aes(yintercept = 0),color = "gray", alpha = 0.2)+
      geom_hline(aes(yintercept = 150),color = "gray", alpha = 0.2)+
      geom_hline(aes(yintercept = 300),color = "gray", alpha = 0.2)+
      
      geom_image(aes(x = driver.name, y = points, image = cars),size = 0.2)+
      geom_text(aes(x = driver.name, y = -50, label = driver.name), 
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
        panel.grid = element_blank(),
        plot.title = element_text(color = "white", family = "Formula1 Display-Regular", hjust = 0.5, size = 20)
      )+
      labs(x = NULL, y = NULL, title = "F1 2020 - Driver Standings")+
      facet_wrap(~round)+
      facet_null() + 
      #scale_y_continuous(position = "bottom",label = c("", "0", "100", "200", "300", "400"))+
      ylim(-300,450)+
      geom_text(x = 1 , y = 320,
                family = "Formula1 Display-Regular",
                aes(label = str_replace_all(as.character(circuit), "Grand Prix", "GP")),
                size = 5, col = "white")#+
    #transition_time(round)
    
    
  })
  
  
  
  
  
  
}


# 9. SHINY APP ------------------------------------------------------------

shinyApp(ui, server) 