# Library -----------------------------------------------------------------
source("library/library.R")

# Functions ---------------------------------------------------------------
source("functions.R")




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
                menuItem("Circuits", tabName = "tab_circuits", icon = icon("road")),
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
                  source(file.path("ui", "teams.R"),  local = TRUE, encoding = "UTF-8" )$value,
                  # Circuits
                  source(file.path("ui", "circuits.R"),  local = TRUE, encoding = "UTF-8" )$value,
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
    
    # Ana sayfa için
    output$style_tag <- renderUI({
      if(input$tabs=='tab_home'){
        return(tags$head(tags$style(HTML(
      '.content-wrapper {background-image:url("wallpaper/wallpaper2.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
        )}else if(input$tabs=='tab_highlights'){
          return(tags$head(tags$style(HTML(
            '.content-wrapper {background-image:url("wallpaper/70.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
          )
        }else if(input$tabs=='tab_developer'){
          return(tags$head(tags$style(HTML(
            '.content-wrapper {background-image:url("wallpaper/wallpaper1.jpg"); height: 100%; background-position: center;background-repeat: no-repeat;background-size: cover;}')))
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
    
    
    
    
    
    
    
    
    output$team_name <- renderUI({
      
      h1(input$teams)
    })
    
    output$car <- renderUI({
      
      tags$img(src = paste0("cars/",tolower(input$teams),"_car.png"))
      
    })
    
    output$team_logo <- renderUI({
      
      tags$a(tags$img(src = paste0("teams/",tolower(input$teams),".jpg"), width = "300px"),
             href = "https://www.mercedesamgf1.com/en/", target="_blank")
      
    })
    
    
    output$team_driver1_img <- renderUI({
      
      img <- drivers %>% filter(cons.name == input$teams) %>% pull(driver.name)
      
      driver_image(img[1], width = "300px")
      
    })
    
    output$team_driver2_img <- renderUI({
      
      img <- drivers %>% filter(cons.name == input$teams) %>% pull(driver.name)
      
      driver_image(img[2], width = "300px")
      
    })
    
    output$team_driver_name1 <- renderUI({
      
      h3((drivers %>% filter(cons.name == input$teams) %>% pull(driver.name))[1])
      
    })
    
    output$team_driver_name2 <- renderUI({
      
      tags$a(h3((drivers %>% filter(cons.name == input$teams) %>% pull(driver.name))[2]),href="https//:www.google.com", target="_blank")
      
    })
    
    
    
    
    output$highlights_post <- renderUI({
      
      temp <- all_highlights %>% filter(name == input$highlights_circuit,  
                                race_type == input$highlights_type)
      post <- temp %>% pull(img) %>% as.character()
      link <- temp %>% pull(link) %>% as.character()
      
      tags$a(tags$img(src = paste0("highlights/", post)), href=link, target="_blank")
      
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
 
    
}


# 9. SHINY APP ------------------------------------------------------------

shinyApp(ui, server) 