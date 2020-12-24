tabItem(
  tabName = "tab_comp",
  
  fluidRow(
    
    # Select Inputa görsle ekleme
    # pickerInput(inputId = "Id0109",
    #             label = "pickerInput Palettes",
    #             choices = x$val,
    #             choicesOpt = list(content = x$img)),
    
    column(width = 12, 
           
           fluidRow(
             
             column(width = 4,
                    
                    div(style = "margin-left: 22%;", uiOutput("driver1_name")),
                    hr(),
                    box(uiOutput("driver1_img"),height = '100%', width = '100%'),
                    div(style = "margin-left: 20%;", selectInput("driver1", label = NULL,choices = NULL)),
                    hr()
             ),
             column(width = 4, 
                    br(), br(),br(), br(),br(), br(),plotOutput("comp")),
             column(width = 4,
                    div(style = "margin-left: 22%;", uiOutput("driver2_name")),
                    hr(),
                    box(uiOutput("driver2_img"),height = '100%', width = '100%'),
                    div(style = "margin-left: 20%;", selectInput("driver2", label = NULL, choices = NULL)),
                    hr()
                    
                    
             )),
           
           br(),
           
           fluidRow(
           )),
    
    br()
    
  )
  
)