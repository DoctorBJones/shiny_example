# boilerplate text to create modules. This should be a snippet in RStudio under 'shinymod'
# if not, you can add it manually.


#module UI
violin_by_factor_UI <- function(id, continuous_vars) {
  ns <- NS(id)
  tagList(
    myBox_green(width = 4,
                varSelectInput(
                  inputId = NS(id, "yaxis"),
                  label = "Select a variable to compare between species",
                  data = continuous_vars,
                  multiple = FALSE
                )),
    myBox_green(width = 8,
                plotlyOutput(NS(id,"scatter")))
  )
}

#module server
violin_by_factor_server <- function(id, dataset) {
  moduleServer(id, function(input, output, session){
    
    output$scatter <- renderPlotly({
      
       # setting color as well as fill gets rid of weird lines on rendering
      p <- ggplot(dataset, aes_string(x = "Species", y = input$yaxis, 
                                      fill = "Species", color = "Species")) +
        geom_violin() +
        scale_fill_bj(reverse = TRUE) +
        scale_color_bj(reverse = TRUE) +
        theme_bj_vbar() 
      
      ggplotly(p, tooltip = "x")
      
      
    })
  })
}