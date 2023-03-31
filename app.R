
source("ui.R")
source("server.R")


# Different run types

# Run in a dialog within R Studio
#runGadget(ui, server, viewer = dialogViewer("Dialog Title", width = 1200, height = 600))

# Run in Viewer pane
#runGadget(ui, server, viewer = paneViewer(minHeight = 500))

# Run in browser
#runGadget(ui, server, viewer = browserViewer(browser = getOption("browser")))

shinyApp(ui = ui, server = server)
