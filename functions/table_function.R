# Create one-way prop table with optional weights
tab <- function(target, dataset, weights = NULL, stat = "prop") {
  
  if (is.null(weights)) {
    tab <- as.data.frame(wtable(dataset[[target]], stat = stat)) %>%
      filter(Var1 == 1) %>%
      mutate(Var1 = deparse(target))
    
  } else {
    
    tab <- as.data.frame(wtable(dataset[[target]], weights = dataset[["weight"]], stat = stat)) %>%
      filter(Var1 == 1) %>%
      mutate(Var1 = deparse(target))
    
  }
  
  return(tab)
}

