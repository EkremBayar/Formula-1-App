tabItem(
  tabName = "tab_teams",
  
box(
  
  fluidRow(
    column(width = 6, div(style="display:inline-block",h1(strong("Team Information"), style = "color: black;"))),
    # Input
    column(width = 6, div(style="float: right;",
        selectInput("teams", label = NULL, choices = NULL,width = "250px")))
    ),
  hr(),
  
    column(width = 6,
           
           # Logo
           uiOutput("team_logo"), 
           br(),
           # Table
           tableOutput("team_info")),
    
    column(width = 6, align="center",

           br(), 
           
           # Drivers
           div(style="display:inline-block",
               uiOutput("team_driver1_img"),
               uiOutput("team_driver_name1"),
               uiOutput("team_driver_number1"),
               div(style = "display: inline-block;",uiOutput("team_driver_box1")),
               div(style="display:inline-block", uiOutput("team_driver_code1"))
           ),
           div(style="display:inline-block", 
               uiOutput("team_driver2_img"),
               uiOutput("team_driver_name2"),
               uiOutput("team_driver_number2"),
               div(style="display:inline-block", uiOutput("team_driver_box2")),
               div(style="display:inline-block", uiOutput("team_driver_code2"))
            ),
           
           br(),
           hr(),
           br(),
           
           # Car
           uiOutput("car")
           ), 
    
    # Box Config
    solidHeader = TRUE, width = 12, height = "100%")
)