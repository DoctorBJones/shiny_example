# boilerplate text to create modules. This should be a snippet in RStudio under 'shinymod'
# if not, you can add it manually.


#module UI
means_by_factor_UI <- function(id, continuous_vars) {
  ns <- NS(id)
  tagList(
    myBox_green(width = 4,
                varSelectInput(
                  inputId = NS(id, "yaxis"),
                  label = "Select a variable to compare means between sexes",
                  data = continuous_vars,
                  multiple = FALSE
                )),
    myBox_green(width = 8,
                plotlyOutput(NS(id,"bar")))
  )
}

#module server
means_by_factor_server <- function(id, dataset) {
  moduleServer(id, function(input, output, session){
    
    output$bar <- renderPlotly({
      
      plot_data <- penguins |>
        filter(! is.na(Sex)) 
      
      # setting color as well as fill gets rid of weird lines on rendering
      p <- ggplot(plot_data, aes_string(x = "Sex", y = input$yaxis, 
                                      fill = "Sex", color = "Sex")) +
          geom_bar(stat = "summary", fun = "mean") +
          scale_fill_bj(reverse = TRUE) +
          scale_color_bj(reverse = TRUE) +
          theme_bj_vbar() 
        
      ggplotly(p, tooltip = "y")
      
      
    })
  })
}