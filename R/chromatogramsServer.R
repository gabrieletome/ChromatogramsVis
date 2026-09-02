
## update the plot if the slider is changed
observeEvent(input$slider, {
    i <<- as.integer(input$slider)
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
    output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                            xlim = input$chr_xlim,
                                            ylim = input$chr_ylim))
})
## update the plot with the next spectrum
observeEvent(input$nxt, {
    if (i < length(object_reactive())) i <<- i + 1
    updateSliderInput(session = session, inputId = "slider", value = i)
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
    output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                            xlim = input$chr_xlim,
                                            ylim = input$chr_ylim))
})
## update the plot with the previous spectrum
observeEvent(input$prv, {
    if (i > 1) i <<- i - 1
    updateSliderInput(session = session, inputId = "slider", value = i)
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
    output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                            xlim = input$chr_xlim,
                                            ylim = input$chr_ylim))
})
## Update the plot if X range change
observeEvent(input$chr_xlim, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))

    output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                            xlim = input$chr_xlim,
                                            ylim = input$chr_ylim))
})
## Update the plot if Y range change
observeEvent(input$chr_ylim, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))

    output$dfChromatograms <- renderDT(get_df(object_reactive(), i,
                                            xlim = input$chr_xlim,
                                            ylim = input$chr_ylim))
})
## Update the plot if color change
observeEvent(input$chr_color, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
})
## Update the plot if pch change
observeEvent(input$chr_pch, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
})
## Update the plot if cex change
observeEvent(input$chr_cex, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
})
## Update the plot if lwd change
observeEvent(input$chr_lwd, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
})
## Update the plot if bs change
observeEvent(input$chr_bs, {
    output$plotChromatograms <- renderPlot(
        ggplotChromatograms(object_reactive()[i], interactive = interactive,
                        xlim = input$chr_xlim, ylim = input$chr_ylim,
                        col = input$chr_color, pch = input$chr_pch,
                        cex = input$chr_cex, lwd = input$chr_lwd,
                        bs = input$chr_bs))
})

