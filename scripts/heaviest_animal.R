# create a function that gives you the heaviest animal from a dataframe
heaviest_animal <- function(dataframe) {
  stopifnot(is.data.frame(dataframe))
  new_df <- dataframe %>% 
    filter(!is.na(weight)) %>% 
    group_by(year) %>% 
    filter(weight == max(weight)) %>% 
    select(year, genus, species, weight) %>% 
    arrange(year)
  return(new_df)
} 