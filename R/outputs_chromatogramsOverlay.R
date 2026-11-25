#' @rdname chromatogramsOverlayServer
#'
#' @description
#' The function contains all the shiny functions that update the `output` shiny
#' variable of the Chromatograms Overlay plot. It is included alse the function
#' to download the plot and the filtered object.
#'
#' @importFrom utils unzip
#'
#' @keywords internal
# nocov start
base_chromatogramsOverlay <- function(input, output, session, object_reactive,
                                        object_reactive_msexp,
                                        id = "chromatogramsOverlayPlot") {
    ns <- NS(id)

    output[[ns("plotChromatograms_overlay")]] <- renderPlot({
        show_modal_spinner(spin = "half-circle",
                        text = "Loading...")
        req(object_reactive())

        obj <- object_reactive()
        obj <- obj[.parse_chrOverlay_idx(obj, input[[ns("chrOverlay_idx")]])]
        gg <- ggplotChromatogramsOverlay(obj,
                            xlim = input[[ns("chrOverlay_xlim")]],
                            ylim = input[[ns("chrOverlay_ylim")]],
                            col = .get_colors(id, input, obj),
                            pch = input[[ns("chrOverlay_pch")]],
                            cex = input[[ns("chrOverlay_cex")]],
                            lwd = input[[ns("chrOverlay_lwd")]],
                            bs = input[[ns("chrOverlay_bs")]],
                            axes = input[[ns("chrOverlay_showAxes")]],
                            frame.plot = input[[ns("chrOverlay_showBox")]])
        remove_modal_spinner()
        gg
    })

    output[[ns("dfChromatograms_overlay")]] <- renderDT({
        req(object_reactive())

        obj <- object_reactive()
        get_df(obj[.parse_chrOverlay_idx(obj,
                                        input[[ns("chrOverlay_idx")]])],
                xlim = input[[ns("chrOverlay_xlim")]],
                ylim = input[[ns("chrOverlay_ylim")]])
    })

    output[[ns("plotChromatograms_overlay_hover_info")]] <- renderUI({
        hover <- input[[ns("plotChromatograms_overlay_hover")]]

        if(is.null(hover$x) | is.null(hover$y)) {
            return(NULL)
        }
        ## Select the point closest to the mouse
        obj <- object_reactive()
        obj <- obj[.parse_chrOverlay_idx(obj,
                                        input[[ns("chrOverlay_idx")]])]
        v_l <- peaksData(obj)
        mz_name <- mz(obj)
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

    output[[ns("chrOverlay_color_manual")]] <- renderRHandsontable({
        obj <- object_reactive()
        obj <- obj[.parse_chrOverlay_idx(obj, input[[ns("chrOverlay_idx")]])]
        n <- length(obj)
        mz_name <- mz(obj)
        df <- data.frame(
            id = if (any(!is.na(mz_name)) & all(mz_name != Inf)) mz_name
                 else seq_len(n),
            color = rep("#00000080", n))
        print(df)
        rhandsontable(df, rowHeaders = NULL, stretchH = "all", height = 300,
            maxRows = nrow(df), fillHandle = list(direction = "vertical",
                                                autoInsertRow = FALSE)) |>
            hot_col("id", readOnly = TRUE) |>
            hot_col("color", type = "text")
    })

    output[[ns("downloadChromatograms_overlay")]] <- downloadHandler(
        filename = "chromatogramsOverlay.png",
        content = function(file) {
            obj <- object_reactive()
            obj <- obj[.parse_chrOverlay_idx(obj,
                                            input[[ns("chrOverlay_idx")]])]
            ggsave(ggplotChromatogramsOverlay(obj,
                            xlim = input[[ns("chrOverlay_xlim")]],
                            ylim = input[[ns("chrOverlay_ylim")]],
                            col = .get_colors(id, input, obj),
                            pch = input[[ns("chrOverlay_pch")]],
                            cex = input[[ns("chrOverlay_cex")]],
                            lwd = input[[ns("chrOverlay_lwd")]],
                            bs = input[[ns("chrOverlay_bs")]],
                            axes = input[[ns("chrOverlay_showAxes")]],
                            frame.plot = input[[ns("chrOverlay_showBox")]]),
                    filename = file)
        }, contentType = "image/png"
    )

    output[[ns("downloadChromatograms_overlay_RDS")]] <- downloadHandler(
        filename = ifelse(is.null(object_reactive_msexp()),
                            "chromatograms_obj.rds",
                            "msexperimentStash_obj.zip"),
        content = function(file) {
            show_modal_spinner(spin = "half-circle",
                            text = "Loading...")
            obj <- object_reactive()
            obj <- obj[.parse_chrOverlay_idx(obj,
                                            input[[ns("chrOverlay_idx")]])]
            xrange <- round(unlist(rtime(obj)), 2)
            if(is.null(object_reactive_msexp())){
                message("Saving Chromatograms object")
                ## Filter and save chromatograms object
                obj <- .filter_exporting_object(id, input, obj, xrange,
                                                "chrOverlay_xlim")

                obj <- setBackend(obj, ChromBackendMemory())
                obj <- filterEmptyChromatograms(obj)
                f <- saveRDS(obj, file = file)
            } else {
                message("Saving MsExperiment object")
                ## Filter and save MsExperiment object
                obj <- object_reactive_msexp()
                obj <- obj[.parse_chrOverlay_idx(obj,
                                                input[[ns("chrOverlay_idx")]])]
                obj <- .filter_exporting_object(id, input, obj, xrange,
                                                "chrOverlay_xlim")

                ## Save with MsExperimentStash
                saveObject(obj, path = gsub(".zip", "", file),
                            consolidate = TRUE)
                f <- zip(zipfile = file, files = gsub(".zip", "", file),
                    flags = "-r")
            }
            remove_modal_spinner()
            f
        }
    )

    observeEvent(input[[ns("exportGalaxyChromatograms_overlay_zip")]], {
        show_modal_spinner(spin = "half-circle",
                        text = "Exporting...")
        obj <- object_reactive()
        xrange <- round(unlist(rtime(obj)), 2)

        if(!is.null(object_reactive_msexp())){
            obj <- object_reactive_msexp()
            obj <- obj[.parse_chrOverlay_idx(obj,
                                            input[[ns("chrOverlay_idx")]])]
            obj <- .filter_exporting_object(id, input, obj, xrange,
                                            "chrOverlay_xlim")

            filePath <- paste(Sys.getenv("_GALAXY_JOB_HOME_DIR"),
                            "../working/chromatogramsvis_outputs",
                            "msexperimentStash_obj",
                            sep="/")

            saveObject(obj, path = filePath, consolidate = TRUE)
            f <- zip(zipfile = paste0(filePath, ".zip"), files = filePath,
                flags = "-r")
            remove_modal_spinner()
            showModal(modalDialog(
                title = "Data available in Galaxy",
                paste0("The data are now available in Galaxy. Now you can ",
                        "close the app and stop the app to get the data in ",
                        "your history.")
            ))
            f
        } else {
            showModal(modalDialog(
                title = "Error in exporting",
                paste0("The export to Galaxy is currently available only for ",
                        "MsExperimentStash input. We are working on exporting ",
                        "the other file format.")
            ))
        }
    })
}
# nocov end
