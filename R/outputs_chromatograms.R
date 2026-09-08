## ChromatogramsPlot ----
## start by displaying the first spectrum
# nocov start
base_chromatograms <- function(input, output, session, object_reactive, i,
                                id = "chromatogramsPlot") {
    ns <- NS(id)

    output[[ns("plotChromatograms")]] <- renderPlot({
        req(object_reactive())
        req(length(object_reactive()) >= i())

        ggplotChromatograms(object_reactive()[i()],
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]],
                                col = input[[ns("chr_color")]],
                                pch = input[[ns("chr_pch")]],
                                cex = input[[ns("chr_cex")]],
                                lwd = input[[ns("chr_lwd")]],
                                bs = input[[ns("chr_bs")]])
    })

    output[[ns("dfChromatograms")]] <- renderDT({
        req(object_reactive())
        req(length(object_reactive()) >= i())

        get_df(
            object_reactive(),
            i(),
            xlim = input[[ns("chr_xlim")]],
            ylim = input[[ns("chr_ylim")]]
        )
    })

    output[[ns("plotChromatograms_hover_info")]] <- renderUI({
        hover <- input[[ns("plotChromatograms_hover")]]

        if(is.null(hover$x) | is.null(hover$y)) {
            return(NULL)
        }
        ## Select the point closest to the mouse
        v_l <- peaksData(object_reactive()[i()])
        mz_name <- mz(object_reactive()[i()])
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

    output[[ns("downloadChromatograms")]] <- downloadHandler(
        filename = paste0("chromatograms_index_",i(),".png"),
        content = function(file) {
            ggsave(ggplotChromatograms(object_reactive()[i()],
                                xlim = input[[ns("chr_xlim")]],
                                ylim = input[[ns("chr_ylim")]],
                                col = input[[ns("chr_color")]],
                                pch = input[[ns("chr_pch")]],
                                cex = input[[ns("chr_cex")]],
                                lwd = input[[ns("chr_lwd")]],
                                bs = input[[ns("chr_bs")]]),
                    filename = file)
        }, contentType = "image/png"
    )
}
# nocov end
