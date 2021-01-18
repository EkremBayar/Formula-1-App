tabItem(
  tabName = "tab_grand_prix",
  
  
  box(width = 12,
      
      div(style="display:inline-block",h1(strong("Grand Prix"), style = "color: black;")),
      # Input
      div(style="float: right;",
          selectInput("grand_prix", label = NULL,choices = NULL, selected = NULL,width = "290px")),
      hr(),
    
    fluidRow(
      column(width = 6, 
             uiOutput("grand_prix")
      ),
      column(width = 6,
             sliderInput("r", label = NULL,  min = 0, max = 17, value = 0, animate = animationOptions(interval = 900, loop = FALSE)),
             plotOutput("race"))
    )
  )
)
           
           #sliderInput("r", label = NULL,  min = 0, max = 17, value = 0, animate = TRUE)#,
           #plotOutput("race")
 
    # column(width = 6, tags$img(src = "preview2.gif"), 
    #        br(),tags$img(src = "preview.gif"))
  
  
