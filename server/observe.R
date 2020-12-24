observe({
  updateSelectInput(session, "driver1", choices = data$Drivers, selected = "Max Verstappen")
})
observe({
  #updateSelectInput(session, "driver2", choices = data$Drivers[data$Drivers != input$driver1])
  updateSelectInput(session, "driver2", choices = data$Drivers, selected = "Charles Leclerc")
  
})


observe({
  
  updateSelectInput(session, "highlights_circuit", choices = unique(all_highlights$name), selected = "Turkish Grand Prix" )
  
})

observe({
  
  updateSelectInput(session, "highlights_type", choices = get_type(all_highlights, x = input$highlights_circuit),
                    selected = "Qualifying Highlights")
  
})


observe({
  
  updateSelectInput(session, "teams", choices = sort(constructors$cons.name), selected = "Mercedes" )
  
})


observe({
  
  updateSelectInput(session, "circuit", choices = unique(all_highlights$name), selected = "Turkish Grand Prix" )
  
})