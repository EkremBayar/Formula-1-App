tabItem(
  tabName = "tab_highlights",
  
  # Inputs
  selectInput("highlights_circuit", label = NULL, choices = NULL, selected = NULL),
  selectInput("highlights_type", label = NULL, choices = NULL, selected = NULL),
  
  # Video  
  wellPanel(align="center",
            h4("Click to watch", style = "color: white;"),
            h4("the highlights", style = "color: white;"),
            uiOutput("highlights_post"), style = "width:300px; background-color: #535152;")
)