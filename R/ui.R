#' Variable to check if the Shiny is running inside Galaxy
isGalaxyIE <- !is.na(Sys.getenv("_GALAXY_JOB_HOME_DIR", unset = NA))

#' ChromatogramsVis Dashboard UI
#'
#' Creates the user interface for the ChromatogramsVis Shiny application.
#' Provides options to load chromatogram data from various sources (R console,
#' raw files, RDS objects, or Galaxy history) and visualize them in different
#' plot formats.
#'
#' @return A Shiny dashboard page object containing the UI structure
#'
#' @details
#' The UI includes:
#' - A sidebar with import method selection and navigation tabs
#' - Main content area with chromatogram visualization panels
#' - Conditional panels that display based on the selected import method
#'
#' @import shiny
#'
#' @import shinydashboard
#'
#' @importFrom colourpicker colourInput
#'
#' @import htmltools
#'
#' @author Gabriele Tomè
#'
#' @noRd
ui <- dashboardPage(
    skin = "black",
    title = "ChromatogramsVis",
    header = dashboardHeader(
        title="ChromatogramsVis"
    ),
    sidebar = dashboardSidebar(
        radioButtons("input_cat", "Select import method: ",
                    choices = c(
                            na.omit(ifelse(isGalaxyIE, NA, "From R")),
                            "Raw data", "R object",
                            na.omit(ifelse(isGalaxyIE, "Galaxy History", NA))),
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
        conditionalPanel('input.input_cat == "R object"', {
            fluidRow(
                fileInput("rds_file",
                          "Upload the RDS file with the Chromatograms object",
                          accept = ".RDS"),
                actionButton("load_rds_file", "Load object")
            )
        }),
        conditionalPanel('input.input_cat == "Galaxy History"', {
            actionButton("load_galaxy", "Load Galaxy history")
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
