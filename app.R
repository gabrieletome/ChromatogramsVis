library(shiny)

## Load all the functions of ChromatogramsVis package
devtools::load_all()

## Load GUI and backend of the Shiny App
source("R/ui.R", local = TRUE)
source("R/server.R", local = TRUE)

## Run the Shiny App
shinyApp(ui, server)
