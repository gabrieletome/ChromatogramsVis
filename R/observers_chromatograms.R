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

## update the plot with the next spectrum
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

## update the plot with the previous spectrum
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
