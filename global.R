# load you libraries here
library(shiny)
library(shinydashboard)
library(tidyverse)


penguins <- readRDS("data/penguins.rds")


# source your functions here
source("functions/box_green.R") # use the green box if you're using the green theme
source("functions/gauge_plot_function.R")

#options
options(shiny.usecairo = TRUE)