# This module creates a scatterplot where the user can select inputs from a 
# list of continuous variables. It is disaggregated by a single factor variable
# that is hard coded.



#module UI
# To use the UI you will need only the continous vars of interest from your
# dataset to pass to the continuous_vars argument
scatter_UI <- function(id, continuous_vars) {
  ns <- NS(id)
  tagList(
    myBox_green(width = 4,
                varSelectInput(
                  inputId = NS(id, "xaxis"),
                  label = "Select a variable for the x-axis",
                  data = continuous_vars,
                  multiple = FALSE
                ),
                varSelectInput(
                  inputId = NS(id, "yaxis"),
                  label = "Select a variable for the x-axis",
                  data = continuous_vars,
                  multiple = FALSE
                ),
                radioButtons(inputId = NS(id, "smooth_line"),
                             label = "Would you like the regression line displayed?",
                             choices = c("Show regression line", "Don't show regression line"))),
    myBox_green(width = 8,
                plotlyOutput(NS(id,"scatter")))
  )
}

#module server
# To use the server function you only need to pass the dataset. However, if you
# want to change the disaggregation you need to do it in the code below as it
# is hard coded.
scatter_server <- function(id, dataset) {
  moduleServer(id, function(input, output, session){
    
    output$scatter <- renderPlotly({
      
      
      
      if (input$smooth_line == "Show regression line") {
        
        p <- ggplot(dataset, aes_string(x = input$xaxis, y = input$yaxis, colour = "Sex")) +
          geom_point(position = "jitter", size = 0.5) +
          geom_smooth(method = "lm", colour = bj_cols("Text Grey")) +
          scale_color_bj() +
          theme_bj_numeric() %+replace%
          theme(
            legend.title = element_blank()
          ) 
        
      } else if (input$smooth_line == "Don't show regression line") {
        
        p <- ggplot(dataset, aes_string(x = input$xaxis, y = input$yaxis, colour = "Sex")) +
          geom_point(position = "jitter", size = 0.5) +
          scale_color_bj() +
          theme_bj_numeric() %+replace%
          theme(
            legend.title = element_blank()
          ) 
        
      }
      
      ggplotly(p)
      
      
    })
  })
}