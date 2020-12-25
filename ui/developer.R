tabItem(tabName = "tab_developer",
        
        div(
          wellPanel(align = "center", style = "width: 350px;",
                    
                    # Personnel Info
                    h3(tags$strong("Ekrem BAYAR"), style = "color:white;"),
                    
                    tags$img(src = "developer/ekrem.png", width= "300px"), 
                    
                    h4("Data Scientist", style = "color:white;"),
                      
                    # hr(), 
                    # tags$a(h5("FIFA 19 Dashboard", style = "color:white;"), 
                    #        href = "https://ekrem-bayar.shinyapps.io/FifaDash/", target="_blank"),
                    hr(),
                      
                    # Social Buttons
                    socialButton(
                        url = "https://www.linkedin.com/in/ekrem-bayar/",
                        type = "linkedin"
                        ),
                    socialButton(
                        url = "https://github.com/EkremBayar",
                        type = "github"
                      ),
                    socialButton(
                        url = "https://twitter.com/EkremBayar_",
                        type = "twitter"
                      ),
                    socialButton(
                        url = "https://www.instagram.com/ekrembayar_/",
                        type = "instagram"
                      ),
                      
                    # Config
                    style = "background-color: #535152;margin-left: 1050px; margin-top: 230px;"
                    )
            
        )
    
)