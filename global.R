## Global variable for the Shiny App
## Object set to NULL since it is not pass via R console
object <- NULL
## Index of the chromatogram to be visualized
i <- 1

## running as Galaxy Interactive Environment ?
## This variable is either set directly by Galaxy,
## and/or written to /usr/local/lib/R/etc/Renviron.site
## by the interactivetool_chromatogramsvis.xml tool wrapper
isGalaxyIE <- !is.na(Sys.getenv("_GALAXY_JOB_HOME_DIR", unset = NA))
