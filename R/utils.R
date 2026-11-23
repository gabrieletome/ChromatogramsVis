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
#' @keywords internal
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

#' Parse a range selection of chromatograms
#'
#' @param object A `Chromatograms` object.
#' @param text `character(1)` with selection of Chromatograms to visualize.
#'     (e.g. `"1-3,5,8-10"`).
#'
#' @return `integer` vector of unique indixes. If `text` has an invalid
#'     token or selects indixes outside `1::length(object)` the funtion return
#'     the selection with all indexes.
#'
#' @noRd
.parse_chrOverlay_idx <- function(id, object, text) {
    ns <- NS(id)

    n = length(object)
    parts <- strsplit(gsub("\\s", "", text), ",")[[1]]
    idx <- unlist(lapply(parts, function(p) {
        if (grepl("^\\d+$", p)){
            as.integer(p)
        } else if (grepl("^\\d+-\\d+$", p)) {
            r <- as.integer(strsplit(p, "-")[[1]])
            r[1]:r[2]
        } else {
            1:n
        }
    }))
    idx <- unique(idx)
    if (any(idx < 1 | idx > n))
        1:n
    else
        idx
}
