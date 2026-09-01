library(testthat)
library(ChromatogramsVis)
library(MsDataHub)

fl <- MsDataHub::PestMix1_DDA.mzML()
pest_ms2 <- filterMsLevel(Chromatograms(fl), 2L)
pest_ms2 <- pest_ms2[c(808, 809, 945:955)]
