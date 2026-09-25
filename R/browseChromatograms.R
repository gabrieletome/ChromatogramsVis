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
#' @param isGalaxyIE A logical value indicating whether the Shiny app is running
#'     inside a Galaxy Interactive Environment (IE). If `TRUE`, the app will
#'     adjust its behavior to accommodate the Galaxy environment. If `FALSE`,
#'     the app will run in a standard Shiny environment. The default value is
#'     `FALSE`.
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
#' @importFrom MsExperiment MsExperiment spectra
#'
#' @import htmltools
#'
#' @author Gabriele Tomè
#'
#' @export
browseChromatograms <- function(object = NULL, isGalaxyIE = FALSE) {
    if(!is.null(object)){
        stopifnot(inherits(object, c("Chromatograms", "MsExperiment")))
        if (!length(object))
            stop("The 'Chromatograms' object is empty.")
    }

    shinyApp(ui(isGalaxyIE), server(object))
}

