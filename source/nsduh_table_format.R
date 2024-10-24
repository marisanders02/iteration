nsduh_import <- function(html, table, drug) {
  
  output_df <-
    html %>% 
    html_table() %>% 
    nth(table) %>%  
    slice(-1) %>% 
    mutate(drug = drug) %>%  
    select(-contains("P Value"))
  
  return(output_df)
}