## Chromatograms Overlay ----
# nocov start
base_chromatogramsOverlay <- function(input, output, session, object_reactive,
                                        id = "chromatogramsOverlayPlot") {
    ns <- NS(id)

    output[[ns("plotChromatograms_overlay")]] <- renderPlot({
        req(object_reactive())

        ggplotChromatogramsOverlay(object_reactive(),
                            xlim = input[[ns("chrOverlay_xlim")]],
                            ylim = input[[ns("chrOverlay_ylim")]],
                            col = input[[ns("chrOverlay_color")]],
                            pch = input[[ns("chrOverlay_pch")]],
                            cex = input[[ns("chrOverlay_cex")]],
                            lwd = input[[ns("chrOverlay_lwd")]],
                            bs = input[[ns("chrOverlay_bs")]],
                            axes = input[[ns("chrOverlay_showAxes")]],
                            frame.plot = input[[ns("chrOverlay_showBox")]])
    })

    output[[ns("dfChromatograms_overlay")]] <- renderDT({
        req(object_reactive())

        get_df(object_reactive(),
                xlim = input[[ns("chrOverlay_xlim")]],
                ylim = input[[ns("chrOverlay_ylim")]])
    })

    output[[ns("plotChromatograms_overlay_hover_info")]] <- renderUI({
        hover <- input[[ns("plotChromatograms_overlay_hover")]]

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

    output[[ns("downloadChromatograms_overlay")]] <- downloadHandler(
        filename = "chromatogramsOverlay.png",
        content = function(file) {
            ggsave(ggplotChromatogramsOverlay(object_reactive(),

                            xlim = input[[ns("chrOverlay_xlim")]],
                            ylim = input[[ns("chrOverlay_ylim")]],
                            col = input[[ns("chrOverlay_color")]],
                            pch = input[[ns("chrOverlay_pch")]],
                            cex = input[[ns("chrOverlay_cex")]],
                            lwd = input[[ns("chrOverlay_lwd")]],
                            bs = input[[ns("chrOverlay_bs")]],
                            axes = input[[ns("chrOverlay_showAxes")]],
                            frame.plot = input[[ns("chrOverlay_showBox")]]),
                    filename = file)
        }, contentType = "image/png"
    )
}
# nocov end
