#' Extract peak information from a chromatogram object and reshape it into a
#' data frame. Optional sample subsetting and range filters can be applied to
#' retention time and intensity.
#'
#' @param object A `chromatograms` object containing peak data.
#'
#' @param i Optional index selecting samples from `object`.
#'
#' @param xlim Optional `numeric(2)` with the allowed retention-time range.
#'
#' @param ylim Optional `numeric(2)` with the allowed intensity range.
#'
#' @return A `data.frame` with `mz`, `rtime`, and `intensity` columns, rounded
#'     to two decimal places. When `!is.null(i)`, the `mz` column is removed.
#'
#' @importFrom Chromatograms peaksData mz
#'
#' @importFrom Spectra rbindlistWithRownames
#'
#' @author Gabriele Tomè
#'
#' @noRd
get_df <- function(object, i = NULL, xlim = NULL, ylim = NULL) {
    if(is.null(i)){
        v_l <- peaksData(object)
        mz_name <- mz(object)
    } else{
        v_l <- peaksData(object[i])
        mz_name <- mz(object[i])
    }
    if(any(!is.na(mz_name)))
        names(v_l) <- mz_name
    v <- rbindlistWithRownames(v_l, idcol = "mz")
    if(is.null(i))
        v$mz <- as.character(v$mz)
    else
        v$mz <- NULL

    v$rtime <- round(v$rtime, 2)
    v$intensity <- round(v$intensity, 2)
    if(!is.null(xlim))
        v <- v[(v$rtime >= xlim[1] & v$rtime <= xlim[2]) | is.na(v$rtime), ]
    if(!is.null(ylim))
        v <- v[(v$intensity >= ylim[1] & v$intensity <= ylim[2]) |
                is.na(v$intensity), ]
    v
}
