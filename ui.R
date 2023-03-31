

# UI argument ----

ui <- dashboardPage(
  #Header
  dashboardHeader(title = "Penguins"),
  
  #Sidebar
  dashboardSidebar(id = "",
                   sidebarMenu(
                     menuItem("Homepage", tabName = "Homepage"),
                     menuItem("Gender differences", tabName = "genderdiffs"),
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
                column(width = 12,
                       myBox_green(width = 3,
                                   tags$a(
                                     imageOutput("penguins", height = "150px"),
                                     href = "https://allisonhorst.github.io/palmerpenguins/articles/intro.html", 
                                     target="_blank")
                       ))
                 ),
              fluidRow(
                myBox_green(width = 12, height = 15)
                ),
              
              fluidRow(
                myBox_green(width = 12, height = 8,
                            background = "#2A9D8F"
                )),
              fluidRow(
                myBox_green(width = 12,
                            title = h1("Penguins of the Antarctic",
                                       style = "font-size:40px;text-align: center"))
              ),
              fluidRow(
                myBox_green(width = 12,
                            p("Dr Kristen Gorman collected data on penguins
                              at the Palmer station in Antarctica. With Allison 
                              Horst and Alison Hill she made the data publicly
                              available through the palmerpenguins R package. 
                              This web app explores the data as a
                              demonstration of Shiny.", style = "font-size:20px"))
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
                       p("of penguins were observed \n on Torgersen Island",
                         style = "font-size:20px;text-align:center;color:white"))
              )
      ),
      
      # Tab two ----
      tabItem(tabName = "genderdiffs"
              ),
      
      #Tab three ----
      tabItem(tabName = "speciesdiffs"
              )
      
    
    )
    
    
  ))
