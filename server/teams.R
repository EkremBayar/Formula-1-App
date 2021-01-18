# Team Car
output$car <- renderUI({
  
  tags$img(src = paste0("cars/",input$teams,".png"))
  
})

# Team Logo
output$team_logo <- renderUI({
  
  tags$a(tags$img(src = paste0("teams/",tolower(input$teams),".jpg"), width = "300px"),
         href = constructors %>% filter(cons.name == input$teams) %>% pull(cons.url), target="_blank")
  
})


# Team Info
output$team_info <- renderTable(colnames = FALSE, hover = T, {
  
  team %>% filter(Team == input$teams) %>% select(-Team)
  
})


# Driver Image
output$team_driver1_img <- renderUI({
  
  img <- drivers %>% filter(cons.name == input$teams) %>% pull(driver.name)
  
  driver_image(img[1], width = "300px")
  
})

output$team_driver2_img <- renderUI({
  
  img <- drivers %>% filter(cons.name == input$teams) %>% pull(driver.name)
  
  driver_image(img[2], width = "300px")
  
})

# Driver Name
output$team_driver_name1 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  tags$a(h3((temp %>% pull(driver.name))[1]),
         href=(temp %>% pull(url))[1], target="_blank")
  
})

output$team_driver_name2 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 

  tags$a(h3((temp %>% pull(driver.name))[2]),
         href=(temp %>% pull(url))[2], target="_blank")
  
})

# Driver Number
output$team_driver_number1 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 

  h3(tags$strong((temp %>% pull(driver.number))[1]))
  
})

output$team_driver_number2 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  h3(tags$strong((temp %>% pull(driver.number))[2]))
  
})

# Driver Code & Box

output$team_driver_box1 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  if(input$teams == "AlphaTauri"){
    colors <- "#0A2840"
  }else{
    colors <- (temp %>% pull(colors))[1]
  }
  
  HTML(paste0('<div style="background-color:', colors,';width:9px;height:20px;"></div>'))
  
})

output$team_driver_box2 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  if(input$teams == "AlphaTauri"){
    colors <- "#0A2840"
  }else{
    colors <- (temp %>% pull(colors))[1]
  }
  
  HTML(paste0('<div style="background-color:', colors,';width:9px;height:20px;"></div>'))
  
})


output$team_driver_code1 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  h3(tags$strong((temp %>% pull(code))[1]))
  
})

output$team_driver_code2 <- renderUI({
  
  temp <- drivers %>% filter(cons.name == input$teams) 
  
  h3(tags$strong((temp %>% pull(code))[2]))
  
})






