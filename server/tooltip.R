get_type <- function(df, x = "Race"){
  
  res <- NULL
  
  if(is.null(x)) return(res)
  if(missing("df") ) return(res)
  if(is.null(df)) return(res)
  
  res <- df %>% filter(name == x) %>% pull(img)
  res <- str_remove_all(res, ".webp")
  res <- str_remove_all(res, x)
  res <- str_trim(str_remove_all(res, "-"))
  
  return(res)
}