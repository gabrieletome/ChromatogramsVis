library(testthat)
library(MsDataHub)
library(Chromatograms)
library(ChromatogramsVis)

fl <- MRM.standmix.5.mzML()
be <- backendInitialize(ChromBackendMzR(), files = fl)
chr_mzr <- Chromatograms(be)

test_check("ChromatogramsVis")
