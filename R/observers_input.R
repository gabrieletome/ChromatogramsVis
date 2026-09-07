## Clean if radioButton change
input_cat <- function(input, output, session, object_reactive) {
    observeEvent(input$input_cat, {
        print(paste("input_cat:", input$input_cat))
        output$chromatogramsPlot <- renderUI(NULL)
        output$chromatogramsOverlayPlot <- renderUI(NULL)
        ## clean single variables
        output$plotChromatograms <- renderUI(NULL)
        output$dfChromatograms <- renderUI(NULL)
        output$plotChromatograms_overlay <- renderUI(NULL)
        output$dfChromatograms_overlay <- renderUI(NULL)
        ## clean reactive variable
        object_reactive(NULL)
    })
}

## Load from R parameter
load_r_obj <- function(input, output, session, object, object_reactive) {
    observeEvent(input$load_r_obj, {
        print(object)
        object_reactive(object)

        output$chromatogramsPlot <- renderUI({
            chrGui("chromatogramsPlot", object_reactive())
        })
        output$chromatogramsOverlayPlot <- renderUI({
            chrOverlayGui("chromatogramsOverlayPlot", object_reactive())
        })
    })
}

## Load raw file
load_raw_file <- function(input, output, session, object_reactive) {
    observeEvent(input$load_raw_file, {
        f <- input$raw_file$datapath

        be <- backendInitialize(ChromBackendMzR(), files = f)

        object_reactive(Chromatograms(be))
        print(object_reactive())
        output$chromatogramsPlot <- renderUI(chrGui("chromatogramsPlot", object_reactive()))
        output$chromatogramsOverlayPlot <-
                renderUI(chrOverlayGui("chromatogramsOverlayPlot", object_reactive()))
    })
}

## Load RDS file
load_rds_file <- function(input, output, session, object_reactive) {
    observeEvent(input$load_rds_file, {
        f <- input$rds_file$datapath
        object <- readRDS(f)

        object_reactive(object)
        print(object_reactive())
        output$chromatogramsPlot <- renderUI({
            chrGui("chromatogramsPlot", object_reactive())
        })
        output$chromatogramsOverlayPlot <- renderUI({
            chrOverlayGui("chromatogramsOverlayPlot",
                         object_reactive())
        })
    })
}

## Load Galaxy history
load_galaxy <- function(input, output, session, object_reactive) {
    observeEvent(input$load_galaxy, {
        setwd(paste(Sys.getenv("_GALAXY_JOB_HOME_DIR"),"../working",sep="/"))
        print(getwd())
        config <- jsonlite::fromJSON("chromatogramsvis-gxit-inputs.json")
        print(config)

        if (config$input_mode$mode == "rds") {
            filePath <- config$input_mode$rds_file
            object <- readRDS(filePath)
        } else if (config$input_mode$mode == "raw") {
            filePath <- config$input_mode$raw_file
            be <- backendInitialize(ChromBackendMzR(), files = filePath)
            object <- Chromatograms(be)
        } else {
            stop("Invalid input mode")
        }

        object_reactive(object)
        print(object_reactive())
        output$chromatogramsPlot <- renderUI(chrGui("chromatogramsPlot", object_reactive()))
        output$chromatogramsOverlayPlot <-
                renderUI(chrOverlayGui("chromatogramsOverlayPlot", object_reactive()))

        ## Not here, but for completeness:
        ## Here is where the output would go:
        setwd(paste(Sys.getenv("_GALAXY_JOB_HOME_DIR"),"../working/chromatogramsvis_outputs",sep="/"))
    })
}
