library(shiny)
library(shinydashboard)
library(colourpicker)
library(DT)
library(htmltools)
library(ggplot2)
library(Chromatograms)
library(Spectra)

## Load ChromatogramsVis functions, GUI and server
library(ChromatogramsVis)

## running as Galaxy Interactive Environment ?
## This variable is either set directly by Galaxy,
## and/or written to /usr/local/lib/R/etc/Renviron.site
## by the interactivetool_chromatogramsvis.xml tool wrapper
isGalaxyIE <- !is.na(Sys.getenv("_GALAXY_JOB_HOME_DIR", unset = NA))

## Run the Shiny App
browseChromatograms(isGalaxyIE = isGalaxyIE)
