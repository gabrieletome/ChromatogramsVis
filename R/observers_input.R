## Clean if radioButton change
# nocov start
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
# nocov end

## Load from R parameter
# nocov start
load_r_obj <- function(input, output, session, object, object_reactive) {
    observeEvent(input$load_r_obj, {
        if (is.null(object)) {
            showModal(modalDialog(
                title = "Missing object",
                "Something went wrong! Missing R object parameter"
            ))
        } else {
            print(object)
            object_reactive(object)

            output$chromatogramsPlot <- renderUI({
                chrGui("chromatogramsPlot", object_reactive())
            })
            output$chromatogramsOverlayPlot <- renderUI({
                chrOverlayGui("chromatogramsOverlayPlot", object_reactive())
            })
        }
    })
}
# nocov end

## Load raw file
# nocov start
load_raw_file <- function(input, output, session, object_reactive) {
    observeEvent(input$load_raw_file, {
        if (is.null(input$raw_file)) {
            showModal(modalDialog(
                title = "Missing file",
                "Missing file. Please provide a valid input."
            ))
        } else {
            f <- input$raw_file$datapath

            be <- backendInitialize(ChromBackendMzR(), files = f)

            object_reactive(Chromatograms(be))
            print(object_reactive())
            output$chromatogramsPlot <- renderUI(chrGui("chromatogramsPlot", object_reactive()))
            output$chromatogramsOverlayPlot <-
                    renderUI(chrOverlayGui("chromatogramsOverlayPlot", object_reactive()))
        }
    })
}
# nocov end

## Load RDS file
# nocov start
load_rds_file <- function(input, output, session, object_reactive) {
    observeEvent(input$load_rds_file, {
        if (is.null(input$rds_file)) {
            showModal(modalDialog(
                title = "Missing file",
                "Missing file. Please provide a valid input."
            ))
        } else {
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
        }
    })
}
# nocov end

## Load Galaxy history
# nocov start
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
            showModal(modalDialog(
                title = "Invalid input",
                "Please provide a valid input."
            ))
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
# nocov end
