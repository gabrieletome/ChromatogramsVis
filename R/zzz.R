#' @importFrom utils packageVersion
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
      paste("\nThis is ChromatogramsVis version", packageVersion("ChromatogramsVis"), "\n",
            " See `?ChromatogramsVis` to get started.\n"))
}
