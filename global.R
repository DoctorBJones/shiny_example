# load you libraries here
library(shiny)
library(shinydashboard)
library(tidyverse)


penguins <- readRDS("data/penguins.rds")


# source functions 
source("functions/box_green.R") 
source("functions/gauge_plot_function.R")

#options
options(shiny.usecairo = TRUE)