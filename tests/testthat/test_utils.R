library(MsDataHub)
f <- MRM.standmix.5.mzML()
be <- backendInitialize(ChromBackendMzR(), files = f)
chr_mzr <- Chromatograms(be)

test_that("get_df works", {

    res <- get_df(chr_mzr)

    expect_s3_class(res, "data.frame")
    expect_equal(names(res), c("mz", "rtime", "intensity"))
    expect_equal(res[1:5, "mz"], rep("1", 5))
    expect_equal(res[1:5, "rtime"], round(rtime(chr_mzr)[[1]][1:5], 2))
    expect_equal(res[1:5, "intensity"], round(intensity(chr_mzr)[[1]][1:5], 2))

    i = 2
    res_i <- get_df(chr_mzr, i = i)
    expect_s3_class(res_i, "data.frame")
    expect_equal(names(res_i), c("rtime", "intensity"))
    expect_equal(res_i[1:5, "rtime"], round(rtime(chr_mzr)[[i]][1:5], 2))
    expect_equal(res_i[1:5, "intensity"],
                round(intensity(chr_mzr)[[i]][1:5], 2))

    res_lim <- get_df(chr_mzr, xlim = c(3.5, 7), ylim = c(30000, 40000))
    expect_true(all(res_lim$rtime >= 3.5 & res_lim$rtime <= 7))
    expect_true(all(res_lim$intensity >= 30000 & res_lim$intensity <= 40000))
})

test_that(".parse_chrOverlay_idx works", {
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "3"), 3L)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "2-4"), 2:4)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "1-3,5,8-10"), c(1:3, 5L, 8:10))
    expect_equal(.parse_chrOverlay_idx(chr_mzr, " 1 - 3 , 5 "), c(1:3, 5L))
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "2,2,1-3"), c(2L, 1L, 3L))

    all <- 1:length(chr_mzr)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "abc"), all)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "1,abc"), all)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "0"), all)
    expect_equal(.parse_chrOverlay_idx(chr_mzr, "5-200"), all)
})
