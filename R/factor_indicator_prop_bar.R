# This module creates a vertical bar plot that compares groups of a factor variable
# on the percentage of '1' responses of a binary indicator variable.
# The percentage can be weighted, or unweighted. You *cannot* use this module for frequencies.
# The proportions can be calculated on rows or columns.
# The user can select from multiple comparison factors and multiple indicators.


# To use the UI function, the group_vars dataset should be a collection of factor variables
# and the target_var should be a collection of binary (0,1) indicator variables in which
# you are interested only in the '1' responses. For example, the 1 might indicate
# NET positive responses to survey items, or the outcome of an RCT intervention.

factor_indicator_prop_bar_UI <- function(id, group_vars, target_var) {
  tagList(
    myBox_green(width = 4,
          varSelectInput(
            inputId = NS(id, "group_by"),
            label = "What groups would you like to compare?",
            data = group_vars,
            multiple = FALSE
          ),
          varSelectInput(
            inputId = NS(id, "target"),
            label = "Choose your variable of interest:",
            data = target_var,
            multiple = FALSE
          )),
    myBox_green(width = 8,
          plotlyOutput(NS(id,"domain_by_iv")))
  )
}

# To use the server function, you should specify the dataset in which you want the comparison to occur
# This MUST contain the variables passed to the UI function in group_vars and target_var.
# You can specify the weights variable (if you are using it) as a quoted string.
# You also need to specify the stat. This will be "rprop" by default, but you can change it to "cprop"
# for column proportions if you want to.


factor_indicator_prop_bar_server <- function(id, dataset, weights = NULL, stat = "rprop") {
  moduleServer(id, function(input, output, session){
    
    output$domain_by_iv <- renderPlotly({
      
      if (is.null(weights)) {
        
        plot_data <- as.data.frame(wtable(dataset[[input$group_by]],
                                          dataset[[input$target]], stat = stat))
        
      } else {
        
        plot_data <- as.data.frame(wtable(dataset[[input$group_by]],
                                          dataset[[input$target]],
                                          weights = dataset[[weights]], stat = stat))
      }
      
      plot_data <- plot_data %>%
        tibble::rownames_to_column("Group") %>%
        filter(Group != "Sum") %>%
        select(! c("Sum", "0")) %>%
        rename(Percentage = "1")
      
      p <- ggplot(plot_data, aes(x = Group, y = Percentage, fill = Group)) +
        geom_bar(stat = "identity") +
        scale_fill_BETA() +
        theme_BETA() %+replace%
        theme(
          axis.line.x = element_blank(),
          legend.position = "none",
          axis.text = element_text(size = 10),
          axis.title = element_text(size = 10)
        ) +
        labs(x = NULL, y = NULL)
      
      ggplotly(p, tooltip = "Percentage")
      
    })
  })
}
