

chrOverlayGui <- function (object){
    xrange <- round(unlist(rtime(object)), 2)
    yrange <- round(unlist(intensity(object)), 2)
    tagList(
        column(
            width = 3,
            sliderInput("chrOverlay_xlim", "Resize X axes:",
                        value = c(min(xrange), max(xrange)),
                        min = min(xrange), max = max(xrange), dragRange = TRUE),
            sliderInput("chrOverlay_ylim", "Resize Y axes:",
                        value = c(min(yrange), max(yrange)),
                        min = min(yrange), max = max(yrange), dragRange = TRUE),
            colourInput("chrOverlay_color", "Select color: ", value = "#00000080"),
            numericInput("chrOverlay_bs", "Font size: ", value = 16, min = 1),
            numericInput("chrOverlay_pch", "Plotting symbol: ", value = 20,
                         min = 0, max = 25),
            numericInput("chrOverlay_cex", "Size symbol: ", value = 3,
                         min = 0.1, step = 0.1),
            numericInput("chrOverlay_lwd", "Line width: ", value = 0.5,
                         min = 0.1, step = 0.1),
            checkboxInput("chrOverlay_showAxes", "Show axes", value = TRUE),
            checkboxInput("chrOverlay_showBox", "Show frame box", value = TRUE)
        ),
        column(
            width = 5,
            downloadButton("downloadChromatograms_overlay",
                            "Download the figure"),
            hr(),
            plotOutput("plotChromatograms_overlay",
                        hover = hoverOpts(
                                        id = "plotChromatograms_overlay_hover",
                                        delay = 50, delayType = "debounce",
                                        clip = FALSE, nullOutside = FALSE
                    )),
            uiOutput("plotChromatograms_overlay_hover_info")
        ),
        column(
            width = 4,
            hr(),
            DTOutput("dfChromatograms_overlay")
        )
    )
}
