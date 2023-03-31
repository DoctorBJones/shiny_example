# This module creates a scatterplot with fixed x and y numeric vars, and a user input
# to select a factor variable as a colour aesthetic.

# To use the UI function the data parameter should be a collection of factor variables
# (or variables that R can coerce into a factor).
factor_continuous_scatter_UI <- function(id, group_vars) {
  ns <- NS(id)
  tagList(
    myBox_green(width = 4,
                varSelectInput(
                  inputId = NS(id, "group_by"),
                  label = "What groups would you like to compare?",
                  data = group_vars,
                  multiple = FALSE
                ),
                radioButtons(inputId = NS(id, "smooth_line"),
                             label = "Would you like the regression line displayed?",
                             choices = c("Show regression line", "Don't show regression line"))),
    myBox_green(width = 8,
                plotlyOutput(NS(id,"scatter")))
  )
}


# To use the server function, you should specify the dataset in which you want the comparison to occur
# This MUST contain the variables passed to the UI function in group_vars.
# You then need to specify the x and y variables for your scatterplot, as quoted strings.
# It also includes a geom_smooth line - you can comment this out or change the method if you like.
factor_continuous_scatter_server <- function(id, dataset, x, y) {
  moduleServer(id, function(input, output, session){
    
    output$scatter <- renderPlotly({
      
      
      
      if (input$smooth_line == "Show regression line") {
        
        p <- ggplot(dataset, aes_string(x = x, y = y)) +
          geom_point(aes_string(colour = input$group_by), position = "jitter", size = 0.5) +
          geom_smooth(method = "lm", colour = BETA_colours("Text Grey")) +
          scale_colour_BETA() +
          theme_BETA() %+replace%
          theme(
            legend.title = element_blank()
          ) +
          labs(x = "Social Distance", y = "Stereotypes") 
        
      } else if (input$smooth_line == "Don't show regression line") {
        
        p <- ggplot(dataset, aes_string(x = x, y = y)) +
          geom_point(aes_string(colour = input$group_by), position = "jitter", size = 0.5) +
          scale_colour_BETA() +
          theme_BETA() %+replace%
          theme(
            legend.title = element_blank()
          ) +
          labs(x = "Social Distance", y = "Stereotypes") 
        
      }
      
      ggplotly(p, tooltip = c("ES_SDS", "stigma_scale"))
      
      
    })
  })
}