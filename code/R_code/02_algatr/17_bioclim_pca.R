R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
pcangsd_data_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/"

source(paste0(R_code_path, "12_tess_src.R"))
setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")


rotation_pca <- as.data.frame(pca$rotation)
rotation_pca$bioclim <- c(1:19)

############## PC1
ggplot(rotation_pca, aes(y=PC1, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC1) |> filter(PC1 > 0.5)
# largest = bio12 (0.87)
# bio12 --> Annual Precipitation

############## PC2
ggplot(rotation_pca, aes(y=PC2, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC2) |> filter(PC2 > 0.5)
# largest = bio04 (0.96)
# bio04 -->  Temperature Seasonality

############## PC3
ggplot(rotation_pca, aes(y=PC3, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC3) |> filter(PC3 < -0.5)
# largest = bio18 (-0.65) and bio19 (0.56)
# bio18 --> Precipitation of Warmest Quarter
# bio19 --> Precipitation of Coldest Quarter

ggplot (rotation_pca, aes (x=PC1, y=PC2)) +
  geom_point()