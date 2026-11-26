test_that("browseChromatograms works", {
    expect_error(browseChromatograms(object = character()), 'is not TRUE')
    expect_error(browseChromatograms(object = Chromatograms()),
                "object is empty")
    expect_no_error(browseChromatograms(object = chr))

    ## Check MsStash error
    expect_error(browseChromatograms(msStashPath = 1), "invalid class")
    expect_no_error(browseChromatograms(msStashPath = msStash_dir))
})
