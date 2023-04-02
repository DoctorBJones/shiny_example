

# UI argument ----

ui <- dashboardPage(
  #Header
  dashboardHeader(title = "Penguins"),
  
  #Sidebar
  dashboardSidebar(id = "",
                   sidebarMenu(
                     menuItem("Homepage", tabName = "Homepage"),
                     menuItem("Sex differences", tabName = "sexdiffs"),
                     menuItem("Species differences", tabName = "speciesdiffs")
                   )),
  
  #Body
  dashboardBody(
    
    includeCSS("www/green_site.css"), 
    
    # Build each page as a tab item
    tabItems(
      
      # Tab one ----
      tabItem(tabName = "Homepage",
              fluidRow(
                column(width = 3,
                       myBox_green(width = 3,
                            tags$a(
                              imageOutput("penguins", height = "250px"),
                              href = "https://allisonhorst.github.io/palmerpenguins/articles/intro.html", 
                              target="_blank")
                       )),
                column(width = 6, 
                       myBox_green(width = 9,
                            title = h1("Penguins of the Antarctic",
                                       style = "font-size:70px;text-align: center")))
              ),
                 
              fluidRow(
                myBox_green(width = 12, height = 15)
                ),
              
              fluidRow(
                myBox_green(width = 12, height = 8,
                            background = "#2A9D8F"
                )),
              
              fluidRow(
                myBox_green(width = 12, height = 50)
              ),
              
              fluidRow(
                myBox_green(width = 12,
                            p("Dr Kristen Gorman collected data on penguins
                              at the Palmer station in Antarctica. With Allison 
                              Horst and Alison Hill she made the data publicly
                              available through the palmerpenguins R package. 
                              Bethany Jones created this web app to explore the 
                              data as a demonstration of Shiny.", 
                              style = "font-size:20px"))
              ),
              fluidRow(
                column(width = 6, align = "center",
                       div(style = "height:200px;",
                           gauge_plot_UI("sex"))),
                
                column(width = 6, align = "center",
                       div(style = "height:200px;",
                           gauge_plot_UI("island")))
              ),
              fluidRow(
                myBox_green(width = 12, height = 120, 
                            background = "transparent")
              ),
              fluidRow(
                column(width = 6,
                       p("of penguins were male",
                         style = "font-size:20px;text-align:center;color:white")),
                column(width = 6,
                       p("of penguins were observed", tags$br(), "on Torgersen Island",
                         style = "font-size:20px;text-align:center;color:white"))
              )
      ),
      
      # Tab two ----
      tabItem(tabName = "sexdiffs",
              fluidRow(
                myBox_green(width = 12,
                            p("Sex differences in penguins",
                              style = "font-size:42px;test-align:center"))
                
              ),
              fluidRow(
                myBox_green(width = 12,
                            p("Click on the legends to add or remove groups", tags$br(),
                              "Hover over the graphs to display details",
                              style = "font-size:20px"))
                
              ),
              fluidRow(width = 12,
                       scatter_UI("sex", cont_vars)
                
              ),
              fluidRow(width = 12,
                       means_by_factor_UI("means_by_sex", cont_vars)
                       
              )
              ),
      
      #Tab three ----
      tabItem(tabName = "speciesdiffs",
              fluidRow(
                myBox_green(width = 12,
                            p("Species differences in penguins",
                              style = "font-size:42px;test-align:center"))
                
              ),
              fluidRow(
                myBox_green(width = 12,
                       p("Click on the legends to add or remove groups", tags$br(),
                         "Hover over the graphs to display details",
                         style = "font-size:20px"))
                       
              ),
              fluidRow(width = 12,
                       violin_boxplot_factor_UI("species", cont_vars)
                       
              ),
              fluidRow(width = 12,
                       scatter_UI("species_scatter", cont_vars)
                       
              )
              )
      
    
    )
    
    
  ))
