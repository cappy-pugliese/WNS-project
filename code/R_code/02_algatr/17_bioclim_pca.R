R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
pcangsd_data_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/"

source(paste0(R_code_path, "12_tess_src.R"))
setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")


rotation_pca <- as.data.frame(pca$rotation)
rotation_pca$bioclim <- c(1:19)

############## PC1
## looks like has to do with temperature
ggplot(rotation_pca, aes(y=PC1, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC1) |> filter(PC1 > 0.34)
rotation_pca |> select(bioclim, PC1) |> filter(PC1 < -0.3)
# largest pos: 1, 6, 11
  # 01. (0.346) Annual Mean Temperature
  # 06. (0.347) Min Temperature of Coldest Month
  # 11. (0.355) Mean Temperature of Coldest Quarter
# largest neg: 4
  # 04. (-0.303) Temperature Seasonality
  # 07. (-0.249) Temperature Annual Range (BIO5-BIO6)

############## PC2
## looks like some measure of precipitation
ggplot(rotation_pca, aes(y=PC2, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC2) |> filter(PC2 > 0.3) |> arrange(desc(PC2))
rotation_pca |> select(bioclim, PC2) |> filter(PC2 < -0.2) |> arrange(PC2)
# largest pos:
  # 12. (0.383) Annual Precipitation
  # 19. (0.353) Precipitation of Coldest Quarter
  # 17. (0.349) Precipitation of Driest Quarter
  # 16. (0.341) Precipitation of Wettest Quarter
  # 14. (0.339) Precipitation of Driest Month
  # 13. (0.335) Precipitation of Wettest Month
# largest neg: 2, 7
  # 2. (-0.234) Mean Diurnal Range (Mean of monthly (max temp - min temp))
  # 7. (-0.219) Temperature Annual Range (BIO5-BIO6)


############## PC3
## seems to be hotter + wetter (pos) vs colder + drier (neg)
ggplot(rotation_pca, aes(y=PC3, x=bioclim)) +
  geom_point()
rotation_pca |> select(bioclim, PC3) |> filter(PC3 > 0.3) |> arrange(desc(PC3))
rotation_pca |> select(bioclim, PC3) |> filter(PC3 < -0.1) |> arrange(PC3)
# largest pos:
  # 08. (0.548) Mean Temperature of Wettest Quarter
  # 18. (0.410) Precipitation of Warmest Quarter
  # 10 (0.369) Mean Temperature of Warmest Quarter
# largest neg:
  # 19. (-0.201) Precipitation of Coldest Quarter
  # 03. (-0.192) Isothermality (BIO2/BIO7) (×100)
  # 09. (-0.152) Mean Temperature of Driest Quarter

ggplot (rotation_pca, aes (x=PC1, y=PC2)) +
  geom_point()

rotation_pca$variables <- c("Annual Mean Temperature","Mean Diurnal Range (Mean of monthly (max temp - min temp))","Isothermality (BIO2/BIO7) (×100)","Temperature Seasonality (standard deviation ×100)","Max Temperature of Warmest Month","Min Temperature of Coldest Month","Temperature Annual Range (BIO5-BIO6)","Mean Temperature of Wettest Quarter","Mean Temperature of Driest Quarter","Mean Temperature of Warmest Quarter","Mean Temperature of Coldest Quarter","Annual Precipitation","Precipitation of Wettest Month","Precipitation of Driest Month","Precipitation Seasonality (Coefficient of Variation)","Precipitation of Wettest Quarter","Precipitation of Driest Quarter","Precipitation of Warmest Quarter","Precipitation of Coldest Quarter")

PC1_df <- rotation_pca |> select(bioclim, variables, PC1) |> arrange(desc(PC1))

PC2_df <- rotation_pca |> select(bioclim, variables, PC2) |> arrange(desc(PC2))

PC3_df <- rotation_pca |> select(bioclim, variables, PC3) |> arrange(desc(PC3))