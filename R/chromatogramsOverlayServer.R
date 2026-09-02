
## Update the plot if X range change
observeEvent(input$chr_xlim, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
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
})
## Update the plot if Y range change
observeEvent(input$chr_ylim, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
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
})
## Update the plot if color change
observeEvent(input$chr_color, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if pch change
observeEvent(input$chr_pch, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if cex change
observeEvent(input$chr_cex, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if lwd change
observeEvent(input$chr_lwd, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if bs change
observeEvent(input$chr_bs, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if check axes change
observeEvent(input$chrOverlay_showAxes, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
## Update the plot if check box change
observeEvent(input$chrOverlay_showBox, {
    output$plotChromatograms_overlay <- renderPlot(
        ggplotChromatogramsOverlay(object_reactive(), interactive = interactive,
                        xlim = input$chrOverlay_xlim,
                        ylim = input$chrOverlay_ylim,
                        col = input$chrOverlay_color,
                        pch = input$chrOverlay_pch,
                        cex = input$chrOverlay_cex,
                        lwd = input$chrOverlay_lwd,
                        bs = input$chrOverlay_bs,
                        axes = input$chrOverlay_showAxes,
                        frame.plot = input$chrOverlay_showBox))
})
