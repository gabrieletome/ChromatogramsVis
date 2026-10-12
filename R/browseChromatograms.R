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
#' @param msStashPath `character(1)` specifying the path to a MsStash object.
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
#' @importFrom MsStash readMsObject AlabasterParam
#'
#' @import htmltools
#'
#' @author Gabriele Tomè
#'
#' @export
browseChromatograms <- function(object = NULL, msStashPath = NULL) {
    if(!is.null(object)){
        stopifnot(inherits(object, c("Chromatograms", "MsExperiment")))
        if (!length(object))
            stop("The 'Chromatograms' object is empty.")
    } else if (!is.null(msStashPath)){
        ap <- AlabasterParam(msStashPath)
        object <- readMsObject(MsExperiment(), ap)
    }

    shinyApp(ui(galaxy_instance()), server(object))
}


#' @title Check if the Shiny app is running inside a Galaxy Interactive
#'     Environment (IE)
#'
#' @description
#' The `galaxy_instance()` function checks whether the Shiny app is running
#' inside a Galaxy Interactive Environment (IE) by examining the environment
#' variable `_GALAXY_JOB_HOME_DIR`. If this variable is set, it indicates
#' that the app is running within a Galaxy IE.
#'
#' @return `logical(1)` indicating whether the Shiny app is running inside
#'     Galaxy
#'
#' @export
galaxy_instance <- function() {
    !is.na(Sys.getenv("_GALAXY_JOB_HOME_DIR", unset = NA))
}
