library(testthat)
library(shinytest2)
library(MsDataHub)
library(Chromatograms)
library(ChromatogramsVis)

# A data.frame with chromatogram variables.
cdata <- data.frame(
    msLevel = c(1L, 1L),
    mz = c(112.2, 123.3),
    chromIndex = c(1L, 2L)
)
# Retention time and intensity values for each chromatogram.
pdata <- list(
    data.frame(
        rtime = c(11, 12.4, 12.8, 13.2, 14.6, 15.1, 16.5),
        intensity = c(50.5, 123.3, 153.6, 2354.3, 243.4, 123.4, 83.2)
    ),
    data.frame(
        rtime = c(45.1, 46.2, 53, 54.2, 55.3, 56.4, 57.5),
        intensity = c(100, 180.1, 300.45, 1400, 1200.3, 300.2, 150.1)
    )
)
# Create and initialize the backend
be <- backendInitialize(ChromBackendMemory(),
                        chromData = cdata, peaksData = pdata)
chr <- Chromatograms(be)

f <- MRM.standmix.5.mzML()
be <- backendInitialize(ChromBackendMzR(), files = f)
chr_mzr <- Chromatograms(be)

test_check("ChromatogramsVis")

# shinytest2::test_app()
