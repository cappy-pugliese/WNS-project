R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/"
source(paste0(R_code_path, "12_algatr_src.R"))

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")

##### tess tutorial
## https://thewanglab.github.io/algatr/articles/TESS_vignette.html

tess_packages()

krig_raster <- raster::aggregate(og_envpcs$PC1, fact = 6)

tess3_result <- tess_ktest(pruned_dosage, coords, Kvals = 1:15, ploidy = 2, K_selection = "auto")
# predicts k-value to be 3
# different from pcangsd (k-value = 7)

tess3_obj <- tess3_result$tess3_obj
bestK <- tess3_result[["K"]]
# Get Qmatrix with ancestry coefficients
qmat <- qmatrix(tess3_obj, K = bestK)

coords_longlat
krig_raster <- terra::project(krig_raster, "+proj=longlat")

krig_admix <- tess_krig(qmat, coords_longlat, krig_raster)

## bar plot of Q values, k=3
tess_ggbarplot(qmat)

## bar plot of Q values, k=7
#tess3_obj_K7 <- tess3(pruned_dosage, coord = as.matrix(coords), K = 7, method = "projected.ls", ploidy = 2)
#pcangsd_k <- 7
#qmat_k7 <- qmatrix(tess3_obj_K7, K = pcangsd_k)
#tess_ggbarplot(qmat_k7)