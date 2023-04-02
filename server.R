# library(shiny)
# library(shinydashboard)

#include any other libraries


# server function ----

server <- function(input, output) {
  
  # palmerpenguins hex sticker
  output$penguins <- renderImage({
    list(src = "www/palmerpenguins.png", style = "height:250px", contentType = "image/png", 
         alt = "Palmer penguins R package hex sticker")
  }, deleteFile = FALSE) 
  
  gauge_plot_server("sex", 0.504)
  
  gauge_plot_server("island", 0.15)
  
  # Sex differences tab
  scatter_server("sex", penguins, "Sex")
  
  means_by_factor_server("means_by_sex", penguins)
  
  # Species difference tab
  
  violin_boxplot_factor_server("species", penguins)
  
  scatter_server("species_scatter", penguins, "Species")
  
  
}