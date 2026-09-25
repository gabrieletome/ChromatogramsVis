#' Server Logic for input methods
#'
#' @name inputServer
#' @rdname inputServer
#'
#' @aliases input_cat
#' @aliases load_r_obj
#' @aliases load_raw_file
#' @aliases load_rds_file
#' @aliases load_galaxy
#'
#' @description
#'
#' Handle the serve side of the input methods. Load data from various sources
#' (R console, raw files, RDS objects, or Galaxy history), build a
#' Chromatograms object and generate the GUI for the visualization.
#'
#' @details
#' Based on the input:
#' - Load the data
#' - If not a `Chromatograms` object, build it
#' - If `"In memory"` option is selected it change the backend to
#'   `ChromBackendMemory`
#' - Activete the GUIs
#'
#' @param input Shiny input object
#'
#' @param output Shiny output object
#'
#' @param session Shiny session object
#'
#' @param object `Chromatograms` or `MsExperiment` object passed via R console
#'
#' @param object_reactive Shiny reactive object with inside Chromatograms object
#'
#' @author Gabriele Tomè
#'
#' @keywords internal
NULL

#' @rdname inputServer
#'
#' @description
#' Clean the GUI if the input radioButton change
#'
#' @keywords internal
# nocov start
input_cat <- function(input, output, session,
                        object_reactive, object_reactive_msexp) {
    observeEvent(input$input_cat, {
        print(paste("input_cat:", input$input_cat))
        output$sidebarMenu <- renderUI(NULL)
        output$chromatogramsPlot <- renderUI(NULL)
        output$chromatogramsOverlayPlot <- renderUI(NULL)
        ## clean single variables
        output$plotChromatograms <- renderUI(NULL)
        output$dfChromatograms <- renderUI(NULL)
        output$plotChromatograms_overlay <- renderUI(NULL)
        output$dfChromatograms_overlay <- renderUI(NULL)
        ## clean reactive variable
        object_reactive(NULL)
        object_reactive_msexp(NULL)
    })
}
# nocov end

## Load from R parameter
#' @rdname inputServer
#'
#' @description
#' Check if the object is a `Chromatograms` or `MsExperiment`. If it is a
#' `MsExperiment` convert to `Chromatograms` based on the summarized method
#' selected. If `"In memory"` option is selected it change the backend to
#' `ChromBackendMemory`. Activate the GUIs.
#'
#' @keywords internal
# nocov start
load_r_obj <- function(input, output, session, object,
                        object_reactive, object_reactive_msexp) {
    observeEvent(input$load_r_obj, {
        if (is.null(object)) {
            showModal(modalDialog(
                title = "Missing object",
                "Something went wrong! Missing R object parameter"
            ))
        } else {
            stopifnot(inherits(object, c("Chromatograms","MsExperiment")))
            if (inherits(object, "MsExperiment")) {
                ## Save original MsExperiment for later filters
                object_reactive_msexp(object)

                s <- spectra(object)
                object <- backendInitialize(new("ChromBackendSpectra"), s,
                            summarize.method = input$console_summarize_method)
                object <- Chromatograms(object)
            }
            if (!length(object))
                stop("The 'Chromatograms' object is empty.")

            if (input$load_in_memory)
                object <- setBackend(object, ChromBackendMemory())

            object_reactive(object)
            output$chromatogramsPlot <- renderUI({
                chrGui("chromatogramsPlot", object_reactive())
            })
            output$chromatogramsOverlayPlot <- renderUI({
                chrOverlayGui("chromatogramsOverlayPlot", object_reactive())
            })
            output$sidebarMenu <- renderUI({
                sidebarMenu(
                    id="tabs",
                    menuItem("Chromatograms", tabName = "chr", selected = TRUE),
                    menuItem("Chromatograms Overlay", tabName = "chr_overlay")
                )
            })
        }
    })
}
# nocov end

## Load raw file
#' @rdname inputServer
#'
#' @description
#' If `"In memory"` option is selected read the file as `ChromBackendMemory`,
#' otherwise as `ChromBackendMzR`. Activate the GUIs.
#'
#' @keywords internal
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

            if (input$load_in_memory)
                be <- backendInitialize(ChromBackendMemory(), files = f)
            else
                be <- backendInitialize(ChromBackendMzR(), files = f)

            object_reactive(Chromatograms(be))
            print(object_reactive())
            output$chromatogramsPlot <- renderUI(chrGui("chromatogramsPlot", object_reactive()))
            output$chromatogramsOverlayPlot <-
                    renderUI(chrOverlayGui("chromatogramsOverlayPlot", object_reactive()))
            output$sidebarMenu <- renderUI({
                sidebarMenu(
                    id="tabs",
                    menuItem("Chromatograms", tabName = "chr", selected = TRUE),
                    menuItem("Chromatograms Overlay", tabName = "chr_overlay")
                )
            })
        }
    })
}
# nocov end

## Load RDS file
#' @rdname inputServer
#'
#' @description
#' Check if the object inside the `"RDS file"` is a `Chromatograms` or
#' `MsExperiment`. If it is a `MsExperiment` convert to `Chromatograms` based
#' on the summarized method selected. If `"In memory"` option is selected it
#' change the backend to `ChromBackendMemory`. Activate the GUIs.
#'
#' @keywords internal
# nocov start
load_rds_file <- function(input, output, session,
                        object_reactive, object_reactive_msexp) {
    observeEvent(input$load_rds_file, {
        if (is.null(input$rds_file)) {
            showModal(modalDialog(
                title = "Missing file",
                "Missing file. Please provide a valid input."
            ))
        } else {
            f <- input$rds_file$datapath
            object <- readRDS(f)

            stopifnot(inherits(object, c("Chromatograms","MsExperiment")))
            if (input$object_class == "MsExperiment" &
                    inherits(object, "MsExperiment")) {
                ## Save original MsExperiment for later filters
                print(object_reactive_msexp)
                object_reactive_msexp(object)
                print(object_reactive_msexp)

                s <- spectra(object)
                object <- backendInitialize(new("ChromBackendSpectra"), s,
                                    summarize.method = input$summarize_method)
                object <- Chromatograms(object)
            }
            if (!length(object))
                stop("The 'Chromatograms' object is empty.")

            if (input$load_in_memory)
                object <- setBackend(object, ChromBackendMemory())

            object_reactive(object)
            print(object_reactive())
            output$chromatogramsPlot <- renderUI({
                chrGui("chromatogramsPlot", object_reactive())
            })
            output$chromatogramsOverlayPlot <- renderUI({
                chrOverlayGui("chromatogramsOverlayPlot",
                            object_reactive())
            })
            output$sidebarMenu <- renderUI({
                sidebarMenu(
                    id="tabs",
                    menuItem("Chromatograms", tabName = "chr", selected = TRUE),
                    menuItem("Chromatograms Overlay", tabName = "chr_overlay")
                )
            })
        }
    })
}
# nocov end

## Load Galaxy history
#' @rdname inputServer
#'
#' @description
#' Read the Galaxy history and based on the input file read it. Check if the
#' object is a `Chromatograms` or `MsExperiment`. If it is a `MsExperiment`
#' convert to `Chromatograms` based on the summarized method selected. If
#' `"In memory"` option is selected it change the backend to
#' `ChromBackendMemory`. Activate the GUIs.
#'
#' @keywords internal
# nocov start
load_galaxy <- function(input, output, session,
                        object_reactive, object_reactive_msexp) {
    observeEvent(input$load_galaxy, {
        setwd(paste(Sys.getenv("_GALAXY_JOB_HOME_DIR"),"../working",sep="/"))
        print(getwd())
        config <- jsonlite::fromJSON("chromatogramsvis-gxit-inputs.json")
        print(config)

        if (config$input_mode$mode == "rds") {
            filePath <- config$input_mode$rds_file
            object <- readRDS(filePath)
        } else if (config$input_mode$mode == "rds_ms") {
            filePath <- config$input_mode$rds_ms_file
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

        stopifnot(inherits(object, c("Chromatograms","MsExperiment")))
        if (inherits(object, "MsExperiment")) {
            ## Save original MsExperiment for later filters
            object_reactive_msexp(object)

            s <- spectra(object)
            object <- backendInitialize(new("ChromBackendSpectra"), s,
                        summarize.method = config$input_mode$summarize_method)
            object <- Chromatograms(object)
        }
        if (!length(object))
            stop("The 'Chromatograms' object is empty.")


        if (input$load_in_memory)
            object <- setBackend(object, ChromBackendMemory())

        object_reactive(object)
        print(object_reactive())
        output$chromatogramsPlot <- renderUI(chrGui("chromatogramsPlot", object_reactive()))
        output$chromatogramsOverlayPlot <-
                renderUI(chrOverlayGui("chromatogramsOverlayPlot", object_reactive()))
        output$sidebarMenu <- renderUI({
            sidebarMenu(
                id="tabs",
                menuItem("Chromatograms", tabName = "chr", selected = TRUE),
                menuItem("Chromatograms Overlay", tabName = "chr_overlay")
            )
        })

        ## Not here, but for completeness:
        ## Here is where the output would go:
        setwd(paste(Sys.getenv("_GALAXY_JOB_HOME_DIR"),"../working/chromatogramsvis_outputs",sep="/"))
    })
}
# nocov end
