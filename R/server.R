#' ChromatogramsVis Dashboard Server
#'
#' Server logic for the ChromatogramsVis Shiny application.
#' Handles chromatogram data loading from multiple sources (R console, raw
#' files, RDS objects, or Galaxy history) and manages interactive visualization
#' rendering.
#'
#' @param object Optional `chromatograms` object to initialize the app with
#'     preloaded data.
#'
#' @details
#' The server function manages:
#' - Data loading from various input sources with conditional observers
#' - Reactive state management for loaded chromatogram objects
#' - Interactive chromatogram plotting with hover information
#' - Overlay visualization of multiple chromatograms
#' - Data table rendering and download handlers
#'
#' @import shiny
#'
#' @import shinydashboard
#'
#' @importFrom DT renderDT DTOutput
#'
#' @import ggplot2
#'
#' @import Chromatograms
#'
#' @import htmltools
#'
#' @importFrom Spectra rbindlistWithRownames
#'
#' @author Gabriele Tomè
#'
#' @keywords internal
server <- function(object){
    function(input, output, session) {
        i <- reactiveVal(1)
        object_reactive <- reactiveVal()

        ## Input data observers
        input_cat(input, output, session, object_reactive)
        load_r_obj(input, output, session, object, object_reactive)
        load_raw_file(input, output, session, object_reactive)
        load_rds_file(input, output, session, object_reactive)
        load_galaxy(input, output, session, object_reactive)

        ## Chromatograms plot observers
        base_chromatograms(input, output, session, object_reactive, i)
        slider(input, output, session, object_reactive, i)
        nxt(input, output, session, object_reactive, i)
        prv(input, output, session, object_reactive, i)

        ## Chromatograms Overlay plot observers
        base_chromatogramsOverlay(input, output, session, object_reactive)

    }
}
