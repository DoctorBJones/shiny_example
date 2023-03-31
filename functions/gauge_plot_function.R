
# creates a gauge plot with a percentage input
# also choose the colour of the text below the plot (the percent label)
# it defaults to white for use in apps with coloured backgrounds.

gauge_plot <- function (percentage, text_colour = "white") {
  df <- data.frame(matrix(nrow=1, ncol = 1))
  
  names(df) <- c("percentage")
  df$percentage <- c(percentage)
  
  df <- df |> mutate(group=ifelse(percentage <0.5, "red",
                                   ifelse(percentage>=0.5 & percentage<0.8, "orange","green")),
                      label=paste0(percentage*100, "%"))
  
  ggplot(df, aes(fill = group, ymax = percentage, ymin = 0, xmax = 2, xmin = 1)) +
    geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#ece8bd") +
    geom_rect() + 
    coord_polar(theta = "y",start=-pi/2) + xlim(c(0, 2)) + ylim(c(0,2)) +
    geom_text(aes(x = 0, y = 0, label = label), size=10, colour=text_colour, family="Helvetica") +
    theme_void() +
    scale_fill_manual(values = c("red"="#C9146C", "orange"="#DA9112", "green"="#129188")) +
    scale_colour_manual(values = c("red"="#C9146C", "orange"="#DA9112", "green"="#129188")) +
    theme(strip.background = element_blank(),
          strip.text.x = element_blank(),
          rect = element_rect(fill = "transparent"),
          legend.position = "none",
          panel.background = element_rect(color = "transparent"),
          plot.background = element_rect(fill = "transparent", color = "transparent", size = 0),
          plot.margin = unit(c(-2, -0.5, -8, -0.5), "cm")) # top, right, bottom, left
}