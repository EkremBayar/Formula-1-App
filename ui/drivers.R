tabItem(
  tabName = "tab_drivers",
  
  box(width = 12,solidHeader = TRUE, height = "100%",collapsed = T,
      
      div(style="display:inline-block",h1(strong("Driver Information"), style = "color: black;")),
      # Input
      div(style = "float: right;", selectInput("drivers", label = NULL, choices = NULL, selected = NULL,
                      width = "250px")),
      hr(),
      
      column(width = 6,
        
             fluidRow(
               
               column(width = 4,
                      uiOutput("driver_img")
               ),
               
               column(width = 4,
                    div(style="display:inline-block", uiOutput("driver_box")),
                    div(style="display:inline-block", uiOutput("driver_name"),
                    uiOutput("driver_surname"), uiOutput("driver_nat"),
                    uiOutput("driver_dob"), uiOutput("driver_number"), 
                    uiOutput("driver_code"), uiOutput("driver_team"))
                    )
             ),
             
            br(),
             
             fluidRow(style = "margin-left: 5px",
               h4("Total Information", style = "color: black;"),
               tableOutput("driver_info"))
             
    
      ),

      
      column(width = 6,
             tabsetPanel(
               tabPanel("Standings",style = "color: red;",
                        dataTableOutput("dstandings")),
               tabPanel("Results"),
               tabPanel("Lap Times"),
               tabPanel("Qualifying"),
               tabPanel("Pit Stops"),
               tabPanel("Tyres")
             )
             )
    
  )
)