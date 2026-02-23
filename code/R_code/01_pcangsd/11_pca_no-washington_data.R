R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_algatr_src.R"))

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd/04_n-amer-no-washington")

############
pd_locations <- read.csv("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/26_02-23_n-amer-no-washington_locations.csv")
coords
pd_locations$long <- coords$x
pd_locations$lat <- coords$y


############
write.csv(pd_locations,file="26_02-23_n-amer-no-washington_pca-info.csv",row.names=FALSE,quote=FALSE)
