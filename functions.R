driver_image <- function(x, height = '100%', width = '100%'){
  
  tags$img(src = paste0("drivers/",stri_trans_general(str_replace(tolower(x), " ", "_"), 
                                                      "Latin-ASCII"),".jpg"),height = height, width = width)
  
}
