library(shinytest2)

test_that("{shinytest2} recording: ChromatogramVis", {
    appdir <- system.file(package = "ChromatogramsVis", "app")
    local_app_support(test_path(appdir))
    app <- AppDriver$new(test_path(appdir), variant = platform_variant(),
        name = "ChromatogramVis", height = 1319, width = 2201)
    app$expect_screenshot()
    app$set_inputs(input_cat = "R object")
    app$upload_file(rds_file = system.file("rds","test_example.rds", package = "ChromatogramsVis"))
    app$click("load_rds_file")
    app$set_inputs(`chromatogramsPlot-chr_color` = "#00000080")
    # app$click("chromatogramsPlot-prv")
    # app$click("chromatogramsPlot-nxt")
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(11, 57.5))
    app$set_inputs(`chromatogramsPlot-chr_ylim` = c(50.5, 2354.3))
    app$set_inputs(`chromatogramsPlot-slider` = 1)
    app$set_inputs(`chromatogramsPlot-chr_bs` = 16)
    app$set_inputs(`chromatogramsPlot-chr_pch` = 20)
    app$set_inputs(`chromatogramsPlot-chr_cex` = 3)
    app$set_inputs(`chromatogramsPlot-chr_lwd` = 0.5)
    app$set_inputs(`chromatogramsPlot-plotChromatograms_hover` = character(0),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857806079, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$expect_screenshot()
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(11, 22))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857818886, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(12, 22))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4, 5, 6), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4, 5, 6), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857821599, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(13.5, 22))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857822039, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(13, 22))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857822586, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_ylim` = c(71, 2354.3))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857828009, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_ylim` = c(71, 1991))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857830880, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_color` = "#EB262680")
    app$set_inputs(`chromatogramsPlot-chr_bs` = 17)
    app$set_inputs(`chromatogramsPlot-chr_pch` = 19)
    app$set_inputs(`chromatogramsPlot-chr_cex` = 2)
    app$set_inputs(`chromatogramsPlot-chr_lwd` = 0)
    app$set_inputs(`chromatogramsPlot-plotChromatograms_hover` =
                    c(919.515625, 292, 919.515625, 292),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
    app$expect_screenshot()
    app$click("chromatogramsPlot-nxt")
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857852313, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857852717, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-chr_xlim` = c(13, 57.5))
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_current` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_rows_all` =
                    c(1, 2, 3, 4, 5, 6, 7), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsPlot-dfChromatograms_state` =
                    c(1788857855832, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$expect_download("chromatogramsPlot-downloadChromatograms")
    app$expect_screenshot()
    app$set_inputs(`chromatogramsPlot-plotChromatograms_hover` =
                    c(22.515625, 3, 22.515625, 3),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
    app$set_inputs(tabs = "chr_overlay")
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    character(0), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_current` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_all` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_state` =
        c(1788857870264, 0, 10, "", TRUE, FALSE, TRUE,
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE)),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    c(786.515625, 3, 786.515625, 3),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
    app$expect_screenshot()
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    c(20.515625, 41, 20.515625, 41),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_ylim` = c(50.5, 2211))
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_current` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_all` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-dfChromatograms_overlay_state` =
                    c(1788857878494, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_xlim` = c(11.5, 57.5))
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_current` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_all` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_state` =
        c(1788857881679, 0, 10, "", TRUE, FALSE, TRUE,
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE)),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_ylim` = c(91, 2211))
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_current` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_all` =
        c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_state` =
        c(1788857884460, 0, 10, "", TRUE, FALSE, TRUE,
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE),
            c(TRUE, "", TRUE, FALSE, TRUE)),
        allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_xlim` = c(11.5, 54.5))
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_current` =
        c(1, 2, 3, 4, 5, 6, 7, 8), allow_no_input_binding_ = TRUE)
    app$set_inputs(
        `chromatogramsOverlayPlot-dfChromatograms_overlay_rows_all` =
        c(1, 2, 3, 4, 5, 6, 7, 8), allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-dfChromatograms_overlay_state` =
                    c(1788857887805, 0, 10, "", TRUE, FALSE, TRUE,
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE),
                        c(TRUE, "", TRUE, FALSE, TRUE)),
                    allow_no_input_binding_ = TRUE)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_color` = "#3E24A680")
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    c(-1.484375, 246, -1.484375, 246),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_bs` = 17)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_bs` = 18)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_pch` = 19)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_pch` = 18)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_cex` = 5)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_lwd` = 1)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_showAxes` = FALSE)
    app$set_inputs(`chromatogramsOverlayPlot-chrOverlay_showBox` = FALSE)
    app$expect_screenshot()
    app$expect_download(
                "chromatogramsOverlayPlot-downloadChromatograms_overlay")
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    c(53.728721308667, 1505.40523689276, 770.515625, 154,
                      770.515625, 154, 1, 1, "mz", "mz", "rtime",
                      "intensity_orient", 9.35, 56.65, -15, 2317,
                      150.129988483851, 811.353199560981,
                      369.550435865504, 38.9388303269397, character(0),
                      character(0)), allow_no_input_binding_ = TRUE,
                    priority_ = "event")
    app$set_inputs(`chromatogramsOverlayPlot-plotChromatograms_overlay_hover` =
                    c(917.515625, 123, 917.515625, 123),
                    allow_no_input_binding_ = TRUE, priority_ = "event")
})
