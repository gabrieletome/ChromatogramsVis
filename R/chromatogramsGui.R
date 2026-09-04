#' Create GUI for Chromatograms Plot
#'
#' Generates the user interface for the `chromatograms()` plot display.
#' Provides interactive controls for customizing X/Y axis ranges, colors,
#' plotting symbols, and line properties.
#'
#' @param object A chromatograms object to display.
#'
#' @return A Shiny tagList containing the UI layout with three columns:
#'   - Left: Input controls for axis ranges, colors, and visual parameters
#'   - Middle: Navigation buttons, plot with hover information
#'   - Right: Download button and data table
#'
#' @author Gabriele Tomè
#'
#' @noRd
chrGui <- function (object){
    xrange <- round(unlist(rtime(object)), 2)
    yrange <- round(unlist(intensity(object)), 2)
    tagList(
        column(
            width = 2,
            sliderInput("chr_xlim", "Resize X axes:",
                    value = c(min(xrange, na.rm = T), max(xrange, na.rm = T)),
                    min = min(xrange, na.rm = T), max = max(xrange, na.rm = T),
                    dragRange = TRUE),
            sliderInput("chr_ylim", "Resize Y axes:",
                    value = c(min(yrange, na.rm = T), max(yrange, na.rm = T)),
                    min = min(yrange, na.rm = T), max = max(yrange, na.rm = T),
                    dragRange = TRUE),
            colourInput("chr_color", "Select color: ", value = "#00000080",
                        allowTransparent = TRUE),
            numericInput("chr_bs", "Font size: ", value = 16, min = 1),
            numericInput("chr_pch", "Plotting symbol: ", value = 20,
                         min = 0, max = 25),
            numericInput("chr_cex", "Size symbol: ", value = 3,
                         min = 0.1, step = 0.1),
            numericInput("chr_lwd", "Line width: ", value = 0.5,
                         min = 0.1, step = 0.1)
        ),
        column(
            width = 6,
            fluidRow(
                column(
                    width = 3,
                    actionButton("prv", "",
                                icon = icon("chevron-circle-left", "fa-3x"))
                ),
                column(
                    width = 5,
                    sliderInput("slider", "", min = 1, max = length(object),
                                value = 1, step = 1, ticks = FALSE)
                ),
                column(
                    width = 3,
                    actionButton("nxt", "",
                                icon = icon("chevron-circle-right", "fa-3x"))
                )
            ),
            hr(),
            plotOutput("plotChromatograms",
                        hover = hoverOpts(
                        id = "plotChromatograms_hover",
                        delay = 50,
                        delayType = "debounce",
                        clip = FALSE,
                        nullOutside = FALSE
                    )),
            uiOutput("plotChromatograms_hover_info"),
        ),
        column(
            width = 4,
            column(
                width = 6,
                downloadButton("downloadChromatograms",
                                "Download the figure")
            ),
            hr(),
            DTOutput("dfChromatograms")
        )
    )
}
