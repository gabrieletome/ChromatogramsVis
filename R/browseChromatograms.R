#' @title Browse Chromatograms in a Chromatograms object
#'
#' @description
#'
#' The `browseChromatograms()` function opens a simple shiny application
#' that allows to browse trough the individual scans of a `Chromatograms`
#' object.
#'
#' See `?ChromatogramsVis` for an example.
#'
#' @param object A non-empty instance of class `Chromatograms`.
#'
#' @return An object that represents the app.
#'
#' @import shiny
#'
#' @import shinydashboard
#'
#' @importFrom colourpicker colourInput
#'
#' @importFrom DT renderDT DTOutput
#'
#' @importFrom ggplot2 ggsave
#'
#' @import Chromatograms
#'
#' @import htmltools
#'
#' @author Gabriele Tomè
#'
#' @export
browseChromatograms <- function(object = NULL) {
    isGalaxyIE <- FALSE
    if(!is.null(object)){
        stopifnot(inherits(object, "Chromatograms"))
        if (!length(object))
            stop("The 'Chromatograms' object is empty.")
    }
    i <- 1

    source("R/ui.R", local = TRUE)
    source("R/server.R", local = TRUE)

    shinyApp(ui, server)
}
