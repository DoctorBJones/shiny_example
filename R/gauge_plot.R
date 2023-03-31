# This module creates a gauge plot (see gauge_plot_function.R). It isn't dependent on data,
# although you could use data to calculate the proportion you want plotted.


# To use the module UI there is nothing further you need to do. There are no parameters you need to pass
# other than the id.

# module UI
gauge_plot_UI <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(NS(id, "gauge")
  ))
}


# To use the server function you need to pass two arguments in addition to the id. 
# The first, percentage is compulsory. This is expressed as a proportion (e.g. 0.65 for 65%). 
# The second argument is the colour of the text below the graph ("65%"). The default is white and 
# is suitable for dark backgrounds. You can change it any colour.

# module server
gauge_plot_server <- function(id, percentage, text_colour = "white") {
  moduleServer(id, function(input, output, session){
  
    output$gauge <- renderPlot({
      gauge_plot(percentage, text_colour)
    }, bg = "transparent", width = 600, height = 400)
  
})
}