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
#' @export
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
browseChromatograms <- function(object = NULL) {
    if(!is.null(object)){
        stopifnot(inherits(object, "Chromatograms"))
        if (!length(object))
            stop("The 'Chromatograms' object is empty.")
    }
    i <- 1

    ui <- dashboardPage(
        skin = "black",
        title = "ChromatogramsVis",
        header = dashboardHeader(
            title="ChromatogramsVis"
        ),
        sidebar = dashboardSidebar(
            radioButtons("input_cat", "Select import method: ",
                        choices = c("From R", "Raw data","Galaxy"),
                        selected = "From R"),
            conditionalPanel('input.input_cat == "From R"', {
                actionButton("load_r_obj", "Load R console object")
            }),
            conditionalPanel('input.input_cat == "Raw data"', {
                fluidRow(
                    fileInput("raw_file", "Upload the raw file",
                                accept = ".mzml"),
                    actionButton("load_raw_file", "Load file")
                )
            }),
            hr(),
            sidebarMenu(
                id="tabs",
                menuItem("Chromatograms", tabName = "chr", selected = TRUE),
                menuItem("Chromatograms Overlay", tabName = "chr_overlay")
            )
        ),
        body = dashboardBody(
            tabItems(
                tabItem(
                    tabName = "chr",
                    uiOutput("chromatogramsPlot")
                ),
                tabItem(
                    tabName = "chr_overlay",
                    uiOutput("chromatogramsOverlayPlot")
                )
            )
        )
    )

    server <- function(input, output, session) {
        ## Load Chromatograms function
        source("chromatogramsServer.R", local = TRUE)
        source("chromatogramsOverlayServer.R", local = TRUE)

        interactive <- FALSE
        object_reactive <- reactiveVal()

        ## Clean if radioButton change
        observeEvent(input$input_cat, {
            output$chromatogramsPlot <- NULL
            output$chromatogramsPlot_overlay <- NULL
            ## clean single variables
            output$plotChromatograms <- NULL
            output$dfChromatograms <- NULL
            output$plotChromatograms_overlay <- NULL
            output$dfChromatograms_overlay <- NULL
            ## clean reactive variables
            object_reactive <- reactiveVal()
        })

        ## Load from R parameter
        observeEvent(input$load_r_obj, {
            print(object)
            object_reactive(object)

            output$chromatogramsPlot <- renderUI(chrGui(object_reactive()))
            output$chromatogramsOverlayPlot <-
                    renderUI(chrOverlayGui(object_reactive()))
        })
        ## Load raw file
        observeEvent(input$load_raw_file, {
            f <- input$raw_file$datapath

            be <- backendInitialize(ChromBackendMzR(), files = f)

            object_reactive(Chromatograms(be))
            print(object_reactive())
            output$chromatogramsPlot <- renderUI(chrGui(object_reactive()))
            output$chromatogramsOverlayPlot <-
                    renderUI(chrOverlayGui(object_reactive()))
        })

        ## ChromatogramsPlot ----
        ## start by displaying the first spectrum
        output$plotChromatograms <- renderPlot(
            ggplotChromatograms(object_reactive()[i], interactive = interactive,
                                xlim = input$chr_xlim, ylim = input$chr_ylim,
                                col = input$chr_color, pch = input$chr_pch,
                                cex = input$chr_cex, lwd = input$chr_lwd,
                                bs = input$chr_bs))
        output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                                    xlim = input$chr_xlim,
                                                    ylim = input$chr_ylim))

        output$plotChromatograms_hover_info <- renderUI({
            hover <- input$plotChromatograms_hover

            if(is.null(hover$x) | is.null(hover$y)) {
                return(NULL)
            }
            ## Select the point closest to the mouse
            v_l <- peaksData(object_reactive()[i])
            mz_name <- mz(object_reactive()[i])
            if(any(!is.na(mz_name)))
                names(v_l) <- mz_name
            v <- rbindlistWithRownames(v_l, idcol = "mz")
            v$mz <- as.character(v$mz)
            v$intensity_orient <- v[, "intensity"]

            minimumIndex <- nearPoints(v, hover,
                            xvar = "rtime", yvar = "intensity_orient",
                            maxpoints = 1, panelvar1 = "mz", threshold = 5)

            if (!nrow(minimumIndex)) {
                return(NULL)
            }

            info <- paste(
                "<b>rtime: ", "</b>", round(minimumIndex[, "rtime"], 2), "<br>",
                "<b>intensity: ", "</b>", round(minimumIndex[, "intensity"], 2),
                sep = ""
            )

            left_px <- hover$coords_css$x
            top_px <- hover$coords_css$y
            style <- paste0("position:absolute; z-index:100; ",
                            "background-color: rgba(245, 245, 245, 0.85); ",
                            "left:", left_px + 7, "px; top:", top_px + 7, "px;")

            # actual tooltip created as wellPanel
            wellPanel(
                style = style,
                p(HTML(info))
            )
        })

        output$downloadChromatograms <- downloadHandler(
            filename = paste0("chromatograms_index_",i,".png"),
            content = function(file) {
                ggsave(ggplotChromatograms(object_reactive()[i],
                                interactive = interactive,
                                xlim = input$chr_xlim, ylim = input$chr_ylim,
                                col = input$chr_color, pch = input$chr_pch,
                                cex = input$chr_cex, lwd = input$chr_lwd,
                                bs = input$chr_bs),
                        filename = file)
            }, contentType = "image/png"
        )

        ## Chromatograms Overlay ----
        output$plotChromatograms_overlay <- renderPlot(
            ggplotChromatogramsOverlay(object_reactive(),
                                interactive = interactive,
                                xlim = input$chrOverlay_xlim,
                                ylim = input$chrOverlay_ylim,
                                col = input$chrOverlay_color,
                                pch = input$chrOverlay_pch,
                                cex = input$chrOverlay_cex,
                                lwd = input$chrOverlay_lwd,
                                bs = input$chrOverlay_bs,
                                axes = input$chrOverlay_showAxes,
                                frame.plot = input$chrOverlay_showBox))
        output$dfChromatograms_overlay <- renderDT(get_df(object_reactive(),
                                                xlim = input$chrOverlay_xlim,
                                                ylim = input$chrOverlay_ylim))

        output$plotChromatograms_overlay_hover_info <- renderUI({
            hover <- input$plotChromatograms_overlay_hover

            if(is.null(hover$x) | is.null(hover$y)) {
                return(NULL)
            }
            ## Select the point closest to the mouse
            v_l <- peaksData(object_reactive())
            mz_name <- mz(object_reactive())
            if(any(!is.na(mz_name)))
                names(v_l) <- mz_name
            v <- rbindlistWithRownames(v_l, idcol = "mz")
            v$mz <- as.character(v$mz)
            v$intensity_orient <- v[, "intensity"]

            minimumIndex <- nearPoints(v, hover,
                            xvar = "rtime", yvar = "intensity_orient",
                            maxpoints = 1, threshold = 5)

            if (!nrow(minimumIndex)) {
                return(NULL)
            }
            print(minimumIndex)
            info <- paste(
                ifelse(any(!is.na(mz_name)), "<b>mz: ", "<b>index: "),
                "</b>", minimumIndex[, "mz"], "<br>",
                "<b>rtime: ", "</b>", round(minimumIndex[, "rtime"], 2), "<br>",
                "<b>intensity: ", "</b>", round(minimumIndex[, "intensity"], 2),
                sep = ""
            )

            left_px <- hover$coords_css$x
            top_px <- hover$coords_css$y
            style <- paste0("position:absolute; z-index:100; ",
                            "background-color: rgba(245, 245, 245, 0.85); ",
                            "left:", left_px + 7, "px; top:", top_px + 7, "px;")

            # actual tooltip created as wellPanel
            wellPanel(
                style = style,
                p(HTML(info))
            )
        })

        output$downloadChromatograms_overlay <- downloadHandler(
            filename = "chromatogramsOverlay.png",
            content = function(file) {
                ggsave(ggplotChromatogramsOverlay(object_reactive(),
                                interactive = interactive,
                                xlim = input$chrOverlay_xlim,
                                ylim = input$chrOverlay_ylim,
                                col = input$chrOverlay_color,
                                pch = input$chrOverlay_pch,
                                cex = input$chrOverlay_cex,
                                lwd = input$chrOverlay_lwd,
                                bs = input$chrOverlay_bs,
                                axes = input$chrOverlay_showAxes,
                                frame.plot = input$chrOverlay_showBox),
                        filename = file)
            }, contentType = "image/png"
        )

    }

    shinyApp(ui, server)
}
