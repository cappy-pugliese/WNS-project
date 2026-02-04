R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/"
source(paste0(R_code_path, "12_algatr_src.R"))

#libraries
mmrr_packages()
library(here)

Y <- as.matrix(euc_dists)
X <- env_dist
X[["geodist"]] <- geo_dist(coords_longlat)