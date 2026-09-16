#' Server Logic for Chromatograms Plot
#'
#' @name chromatogramsServer
#'
#' @rdname chromatogramsServer
#'
#' @aliases base_chromatograms
#' @aliases slider
#' @aliases nxt
#' @aliases prv
#' @aliases zoom_chromatograms
#' @aliases dblclick_chromatograms
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
#' - Zoom and double click on the plot
#'
#' @param input Shiny input object
#'
#' @param output Shiny output object
#'
#' @param session Shiny session object
#'
#' @param object_reactive Shiny reactive object with inside Chromatograms object
#'
#' @param i Shiny reactive object with the index of the spectra currently
#'     visualized
#'
#' @param id `character(1)` with the ID of the namespace of the input.
#'
#' @author Gabriele Tomè
#'
#' @keywords internal
NULL

#' @rdname chromatogramsServer
#'
#' @description
#' Update the figure based on the slider value.
#'
#' @keywords internal
# nocov start
slider <- function(input, output, session, object_reactive, i,
                    id = "chromatogramsPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("slider")]], {
        print(paste0("Slider value: ", input[[ns("slider")]]))
        i(as.integer(input[[ns("slider")]]))
        output$plotChromatograms <- renderPlot(
            ggplotChromatograms(object_reactive()[i()],
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]],
                                col = input[[ns("chr_color")]],
                                pch = input[[ns("chr_pch")]],
                                cex = input[[ns("chr_cex")]],
                                lwd = input[[ns("chr_lwd")]],
                                bs = input[[ns("chr_bs")]]))
        output$dfChromatograms <- renderDT(get_df(object_reactive(), i(),
                                        xlim = input[[ns("chr_xlim")]],
                                        ylim = input[[ns("chr_ylim")]]))
    })
}
# nocov end

#' @rdname chromatogramsServer
#'
#' @description
#' Update the plot with the next spectrum.
#'
#' @keywords internal
# nocov start
nxt <- function(input, output, session, object_reactive, i,
                    id = "chromatogramsPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("nxt")]], {
        print(paste0("Next button clicked. Current index: ", i()))
        if (i() < length(object_reactive())) i(i() + 1)
        updateSliderInput(session = session, inputId = ns("slider"),
                            value = i())
        output$plotChromatograms <- renderPlot(
            ggplotChromatograms(object_reactive()[i()],
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]],
                                col = input[[ns("chr_color")]],
                                pch = input[[ns("chr_pch")]],
                                cex = input[[ns("chr_cex")]],
                                lwd = input[[ns("chr_lwd")]],
                                bs = input[[ns("chr_bs")]]))
        output$dfChromatograms <- renderDT(get_df(object_reactive(), i(),
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]]))
    })
}
# nocov end

#' @rdname chromatogramsServer
#'
#' @description
#' Update the plot with the previous spectrum.
#'
#' @keywords internal
# nocov start
prv <- function(input, output, session, object_reactive, i,
                    id = "chromatogramsPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("prv")]], {
        if (i() > 1) i(i() - 1)
        updateSliderInput(session = session, inputId = ns("slider"),
                            value = i())
        output$plotChromatograms <- renderPlot(
            ggplotChromatograms(object_reactive()[i()],
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]],
                                col = input[[ns("chr_color")]],
                                pch = input[[ns("chr_pch")]],
                                cex = input[[ns("chr_cex")]],
                                lwd = input[[ns("chr_lwd")]],
                                bs = input[[ns("chr_bs")]]))
        output$dfChromatograms <- renderDT(get_df(object_reactive(), i(),
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]]))
    })
}
# nocov end

#' @rdname chromatogramsServer
#'
#' @description
#' Zoom the plot with brush
#'
#' @keywords internal
# nocov start
zoom_chromatograms <- function(input, output, session,
                            id = "chromatogramsPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("plotChromatograms_brush")]], {
        updateSliderInput(session, ns("chr_xlim"),
                        value = c(input[[ns("plotChromatograms_brush")]]$xmin,
                                input[[ns("plotChromatograms_brush")]]$xmax))
        updateSliderInput(session, ns("chr_ylim"),
                        value = c(input[[ns("plotChromatograms_brush")]]$ymin,
                                input[[ns("plotChromatograms_brush")]]$ymax))
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
dblclick_chromatograms <- function(input, output, session, object_reactive,
                                    id = "chromatogramsPlot") {
    ns <- NS(id)

    observeEvent(input[[ns("plotChromatograms_dblclick")]], {
        xrange <- round(unlist(rtime(object_reactive())), 2)
        yrange <- round(unlist(intensity(object_reactive())), 2)

        if (input[[ns("chr_xlim")]][1] == min(xrange, na.rm = T) &
                input[[ns("chr_xlim")]][2] == max(xrange, na.rm = T) &
                input[[ns("chr_ylim")]][1] == min(yrange, na.rm = T) &
                input[[ns("chr_ylim")]][2] == max(yrange, na.rm = T)) {
            xadd <- (max(xrange, na.rm = T) - min(xrange, na.rm = T)) / 4
            yadd <- (max(yrange, na.rm = T) - min(yrange, na.rm = T)) / 4

            xclick <- input[[ns("plotChromatograms_dblclick")]]$x
            yclick <- input[[ns("plotChromatograms_dblclick")]]$y

            xlim <- c(max(min(xrange, na.rm = T), xclick - xadd),
                      min(max(xrange, na.rm = T), xclick + xadd))
            ylim <- c(max(min(yrange, na.rm = T), yclick - yadd),
                      min(max(yrange, na.rm = T), yclick + yadd))

            updateSliderInput(session, ns("chr_xlim"), value = xlim)
            updateSliderInput(session, ns("chr_ylim"), value = ylim)
        } else {
            updateSliderInput(session, ns("chr_xlim"),
                        value = c(min(xrange, na.rm = T),
                                  max(xrange, na.rm = T)))
            updateSliderInput(session, ns("chr_ylim"),
                        value = c(min(yrange, na.rm = T),
                                  max(yrange, na.rm = T)))

        }
    })

}
# nocov end
