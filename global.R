object <- NULL
if(!is.null(object)){
    stopifnot(inherits(object, "Chromatograms"))
    if (!length(object))
        stop("The 'Chromatograms' object is empty.")
}
i <- 1

## running as Galaxy Interactive Environment ?
## This variable is either set directly by Galaxy,
## and/or written to /usr/local/lib/R/etc/Renviron.site
## by the interactivetool_chromatogramsvis.xml tool wrapper
isGalaxyIE <- !is.na(Sys.getenv("_GALAXY_JOB_HOME_DIR", unset = NA))
