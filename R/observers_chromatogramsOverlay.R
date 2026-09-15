#' Server Logic for Chromatograms Plot
#'
#' @name chromatogramsServer
#'
#' @description
#'
#' Server-side observers for the chromatograms plot display.
#' Handles reactive updates to the plot and data table when user inputs change.
#'
#' @details
#' This module contains multiple `observeEvent` handlers that update the plot
#' and data table when the user modifies:
#' - Slider position for spectrum browsing
#' - Navigation buttons (previous/next spectrum)
#' - X/Y axis ranges
#' - Plot colors and symbols
#' - Line width and font size
#'
#' @author Gabriele Tomè
#'
#' @keywords internal
## Zoom the plot with brush
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
