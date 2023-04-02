# boilerplate text to create modules. This should be a snippet in RStudio under 'shinymod'
# if not, you can add it manually.


#module UI
violin_boxplot_factor_UI <- function(id, continuous_vars) {
  ns <- NS(id)
  tagList(
    myBox_green(width = 4,
                varSelectInput(
                  inputId = NS(id, "yaxis"),
                  label = "Select a variable to compare between species",
                  data = continuous_vars,
                  multiple = FALSE
                ),
                selectInput(
                  inputId = NS(id, "display"),
                  label = "Select a display type",
                  choices = c("Violin plot", "Boxplot"),
                  selected = "Violin plot",
                  multiple = FALSE
                )),
    myBox_green(width = 8,
                plotlyOutput(NS(id,"scatter")))
  )
}

#module server
violin_boxplot_factor_server <- function(id, dataset) {
  moduleServer(id, function(input, output, session){
    
    output$scatter <- renderPlotly({
      
      if (input$display == "Violin plot") {
      
      # setting color as well as fill gets rid of weird lines on rendering
      p <- ggplot(dataset, aes_string(x = "Species", y = input$yaxis, 
                                      fill = "Species", color = "Species")) +
        geom_violin() +
        scale_fill_bj(reverse = TRUE) +
        scale_color_bj(reverse = TRUE) +
        theme_bj_vbar() 
      
      } else {
        p <- ggplot(dataset, aes_string(x = "Species", y = input$yaxis, 
                                        fill = "Species", color = "Species")) +
          geom_boxplot() +
          scale_fill_bj(reverse = TRUE) +
          scale_color_bj(reverse = TRUE) +
          theme_bj_vbar() 
      
      }
      
      ggplotly(p, tooltip = "x")
      
      
    })
  })
}