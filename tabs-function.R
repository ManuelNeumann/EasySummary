# Write funcitons to get an easy overlook over the data: ---
tabs <- function(variable, 
                 lower = 0.025, upper = 0.975,
                 name = deparse(substitute(variable))){
  vectn <- deparse(substitute(variable)) # Get the name of the vector/variable
  
  # If the vector is numeric, give summary statistics and a histogram,
  # else, print an information that vector != numeric
  if (class(variable) == "numeric" || class(variable) == "integer"){
    hist(variable,
         main = paste("Histogram of\n", name))
    smy <- summary(variable)
    quant <- quantile(x = variable, probs = c(lower, upper), na.rm = TRUE)
  } else {
    # Empty Plot:
    plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
    # Warning in the middle:
    text(x = 0.5, y = 0.5, paste("No histogram, since\n", vectn, "\nis not numeric"), 
         cex = 1.6, col = "black")
    smy <- paste("No summary statistics, since", 
                 vectn, 
                 "is not a numeric vector, but has class",
                 class(variable))
    quant <- paste("No quantiles, since", 
                   vectn, 
                   "is not a numeric vector, but has class",
                   class(variable))}
  
  # Create tables ---
  
  # With NAs:
  tabNA <- table(variable, useNA = "always")
  tabNASum <- tabNA %>% addmargins() # With rowmargins
  ptabNA <- tabNA %>% prop.table() %>% {.*100} %>% round(2) # Relative distribution
  
  # Without NAs:
  tab <- table(variable)
  tabSum <- tab %>% addmargins() # With rowmargins
  ptab <- tab %>% prop.table() %>% {.*100} %>% round(2) # Relative distribution
  
  # Make a list out off all elements
  list <- list(smy, quant, tabNASum, ptabNA, tabSum, ptab)
  # Name the elements
  names(list) <- c("Summary",
                   "Quantiles",
                   "Absolute Distribution (with NA)", 
                   "Relative Distribution (with NA)",
                   "Absolute Distribution", 
                   "Relative Distribution")
  
  # Make a barplot:
  table(variable) %>% barplot(main = name)
  
  # Return the list
  return(list)
}