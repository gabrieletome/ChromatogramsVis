library(shiny)

devtools::load_all()

source("R/ui.R", local = TRUE)
source("R/server.R", local = TRUE)

shinyApp(ui, server)
