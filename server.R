library(shiny)
library(shinydashboard)

#include any other libraries


# server function ----

server <- function(input, output) {
  
  # BETA and PMC logos
  output$penguins <- renderImage({
    list(src = "www/palmerpenguins.png", style = "height:150px", contentType = "image/png", 
         alt = "Palmer penguins R package hex sticker")
  }, deleteFile = FALSE) 
  
  gauge_plot_server("sex", 0.504)
  
  gauge_plot_server("island", 0.15)
  
}