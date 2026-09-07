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
