tabItem(
  tabName = "tab_teams",
  
  # Team Name
  uiOutput("team_name"), 
  
  # Input
  selectInput("teams", label = NULL, choices = NULL),
  
  box(
    
    column(width = 6,
           # Logo
           uiOutput("team_logo"), 
           # Car
           uiOutput("car")),
    
    column(width = 6,
           # Drivers
           div(style="display:inline-block",
               uiOutput("team_driver1_img"),
               uiOutput("team_driver_name1")
           ),
           div(style="display:inline-block", 
               uiOutput("team_driver2_img"),
               uiOutput("team_driver_name2"))
           ), 
    
    # Box Config
    solidHeader = TRUE, width = "100%")
)