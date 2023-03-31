# This module creates a horizontal bar plot of the percentage or frequency of 
# '1' responses to a binary indicator variable. The values can be weighted
# or unweighted.
# The user can select one or more indicator variables to include in the plot.


# To use the UI function the target_vars dataset should be a collection of
# binary (0,1) indicator variables in which you are interested only in the 1 responses. 
# For example, the 1 might indicate NET positive responses to survey items, 
# or the outcomes of an RCT intervention.

multi_indicator_bar_UI <- function(id, target_vars) {
  tagList(
  myBox_green(width = 4,
        varSelectInput(
          inputId = NS(id, "life_domain_multi"),
          label = "Compare life domains of interest for all respondents:",
          data = target_vars,
          selected = "By friends",
          multiple = TRUE
        )
  ),
  myBox_green(width = 8,
        plotlyOutput(NS(id, "all_domains"))
  )
  )}

# To use the server function, you should specify the dataset in which you want the comparison to occur
# This MUST contain the variables passed to the UI function.
# If you want weighted values, pass the name of the weights variable as a quoted string.
# The function will default to percentages, but if you want frequencies, pass "freq" to the stat parameter.

# Note: this function relies on another function 'tab' which creates a one-way table of percentages
# or frequencies with tidy labels (weighted or unweighted).

multi_indicator_bar_server <- function(id, dataset, weights = NULL, stat = "prop") {
  moduleServer(id, function(input, output, session){
    
    output$all_domains <- renderPlotly({
      
      out <- lapply(input$life_domain_multi, tab, dataset, weights, stat)
      df <- do.call("rbind", out)
      names(df)[names(df) == "Freq"] <- "Percentage"
      
      
      p <- ggplot(df, aes(y = reorder(Var1, Percentage), x = Percentage)) +
        geom_bar(stat = "identity", fill = BETA_colours("Chart Mid Blue"))+
        scale_y_discrete(labels = wrap_format(40)) +
        theme_BETA() %+replace%
        theme(
          axis.line.y = element_blank(),
          axis.ticks.y.left = element_blank(),
          axis.text.y = element_text(hjust = 1),
          axis.text =element_text(size = 10),
          axis.title=element_text(size=10)
        ) +
        labs(x = NULL,
             y = NULL)
      
      ggplotly(p, height = 600, tooltip = "Percentage")
      
    }
    )
    
    
    
    
  })
}