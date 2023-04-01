# load you libraries here
library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)


penguins <- readRDS("data/penguins.rds")
cont_vars <- readRDS("data/cont_vars.rds")


# source functions 
source("functions/box_green.R") 
source("functions/gauge_plot_function.R")
source("functions/ggplot_colours.R")
source("functions/ggplot_themes.R")


#options
options(shiny.usecairo = TRUE)