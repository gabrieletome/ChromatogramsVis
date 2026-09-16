#' Server Logic for Chromatograms Overlay Plot
#'
#' @name chromatogramsOverlayServer
#'
#' @rdname chromatogramsOverlayServer
#'
#' @aliases base_chromatogramsOverlay
#' @aliases zoom_chromatogramsOverlay
#' @aliases dblclick_chromatogramsOverlay
#'
#' @description
#'
#' Server-side observers for the chromatograms overlay plot display.
#' Handles reactive updates to the plot and data table when user inputs change.
#'
#' @details
#' This module contains multiple `observeEvent` handlers that update the plot
#' and data table when the user:
#' - Zoom or double click on the plot
#'
#' @param input Shiny input object
#'
#' @param output Shiny output object
#'
#' @param session Shiny session object
#'
#' @param object_reactive Shiny reactive object with inside Chromatograms object
#'
#' @param id `character(1)` with the ID of the namespace of the input.
#'
#' @author Gabriele Tomè
#'
#' @keywords internal
NULL

#' @rdname chromatogramsOverlayServer
#'
#' @description
#' Zoom the plot with brush
#'
#' @keywords internal
# nocov start
zoom_chromatogramsOverlay <- function(input, output, session,
                            id = "chromatogramsOverlayPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("plotChromatograms_overlay_brush")]], {
        updateSliderInput(session, ns("chrOverlay_xlim"),
                value = c(input[[ns("plotChromatograms_overlay_brush")]]$xmin,
                        input[[ns("plotChromatograms_overlay_brush")]]$xmax))
        updateSliderInput(session, ns("chrOverlay_ylim"),
                value = c(input[[ns("plotChromatograms_overlay_brush")]]$ymin,
                        input[[ns("plotChromatograms_overlay_brush")]]$ymax))
    })

}
# nocov end

#' @rdname chromatogramsServer
#'
#' @description
#' Zoom/unzoom based on double click
#'
#' @keywords internal
# nocov start
dblclick_chromatogramsOverlay <- function(input, output, session,
                                    object_reactive,
                                    id = "chromatogramsOverlayPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("plotChromatograms_overlay_dblclick")]], {
        xrange <- round(unlist(rtime(object_reactive())), 2)
        yrange <- round(unlist(intensity(object_reactive())), 2)

        if (input[[ns("chrOverlay_xlim")]][1] == min(xrange, na.rm = T) &
                input[[ns("chrOverlay_xlim")]][2] == max(xrange, na.rm = T) &
                input[[ns("chrOverlay_ylim")]][1] == min(yrange, na.rm = T) &
                input[[ns("chrOverlay_ylim")]][2] == max(yrange, na.rm = T)) {
            xadd <- (max(xrange, na.rm = T) - min(xrange, na.rm = T)) / 4
            yadd <- (max(yrange, na.rm = T) - min(yrange, na.rm = T)) / 4

            xclick <- input[[ns("plotChromatograms_overlay_dblclick")]]$x
            yclick <- input[[ns("plotChromatograms_overlay_dblclick")]]$y

            xlim <- c(max(min(xrange, na.rm = T), xclick - xadd),
                      min(max(xrange, na.rm = T), xclick + xadd))
            ylim <- c(max(min(yrange, na.rm = T), yclick - yadd),
                      min(max(yrange, na.rm = T), yclick + yadd))

            updateSliderInput(session, ns("chrOverlay_xlim"), value = xlim)
            updateSliderInput(session, ns("chrOverlay_ylim"), value = ylim)
        } else {
            updateSliderInput(session, ns("chrOverlay_xlim"),
                        value = c(min(xrange, na.rm = T),
                                  max(xrange, na.rm = T)))
            updateSliderInput(session, ns("chrOverlay_ylim"),
                        value = c(min(yrange, na.rm = T),
                                  max(yrange, na.rm = T)))

        }
    })

}
# nocov end
