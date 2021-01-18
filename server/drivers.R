output$driver_box <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  if(temp$cons.name == "AlphaTauri"){
    colors <- "#0A2840"
  }else{
    colors <- (temp %>% pull(colors))[1]
  }
  
  HTML(paste0('<div style="background-color:', colors,';width:9px;height:170px;"></div>'))
  
})



output$driver_name <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  
  
  h5(str_split(temp %>% pull(driver.name), " ")[[1]][1])
  
})


output$driver_surname <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h4(tags$strong(str_split(temp %>% pull(driver.name), " ")[[1]][2]))
  
})

output$driver_number <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h4(tags$strong(temp %>% pull(driver.number)))
  
})

output$driver_code <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h4(tags$strong(temp %>% pull(code)))
  
})

output$driver_team <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h5(temp %>% pull(cons.name))
  
})

output$driver_nat <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h5(temp %>% pull(nationality))
  
})

output$driver_dob <- renderUI({
  
  temp <- drivers %>% filter(driver.name == input$drivers) 
  
  h6(temp %>% pull(dob))
  
})


output$driver_img <- renderUI({
  
  driver_image(input$drivers, width = "200px")
  
})


output$driver_info <- renderTable(colnames = FALSE, hover = T, {
  
  drivers_info %>% filter(driver.name == input$drivers) %>% select(-driver.name)
  
})





output$dstandings <- renderDT({
  
  my_vals = unique(driver_standings$driver.name)
  
  
  if(input$drivers %in% c("Pierre Gasly", "Daniil Kvyat")){
    clr <- "#0A2840"
  }else{
    clr <- as.character(unique((driver_standings %>% filter(driver.name == input$drivers) %>% pull(colors))))
  }
  
  
  my_colors = ifelse(my_vals==input$drivers, clr, "")
  my_colors2 = ifelse(my_vals==input$drivers,'white', "black")
  
datatable(
    driver_standings %>% 
      filter(round == 17) %>% 
      arrange(-points) %>%
      select(position, driver.number, code, driver.name, wins,points) %>% 
      rename(number = driver.number, driver = driver.name) %>% distinct(),
    options = list(
      dom = 't',
      pageLength = 20
    ),rownames = FALSE,
  ) %>% 
    formatStyle('driver', target = 'row', 
                backgroundColor = styleEqual(my_vals,my_colors),
                color = styleEqual(my_vals,my_colors2)) 

  
})





