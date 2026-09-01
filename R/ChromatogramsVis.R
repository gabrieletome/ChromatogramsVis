#' ChromatogramsVis: Visualising and Exploring Chromatograms Data
#'
#' This package defines a set of helper function to visualise and
#' explore mass spectrometry data stored as Chromatograms objects.
#'
#' @section ChromatogramsVis functions:
#'
#' - browseChromatograms: Browse Chromatograms in a Chromatograms object.
#'
#' @docType package
#'
#' @name ChromatogramsVis
#'
#' @examples
#'
#' library(MsDataHub)
#' f <- MRM.standmix.5.mzML()
#'
#' be <- backendInitialize(ChromBackendMzR(), files = f)
#'
#' chr_mzr <- Chromatograms(be)
#' chr_mzr
#'
#' if (interactive())
#'    browseChromatograms(chr_mzr)
#'
#' ## Use Ctrl+C to interrupt R and stop the application
#'
"_PACKAGE"
