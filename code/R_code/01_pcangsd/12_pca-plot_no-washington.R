R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_algatr_src.R"))

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd/04_n-amer-no-washington")

library(paletteer)

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist


## pcangsd tutorial
info <- read.csv("26_02-23_n-amer-no-washington_pca-info.csv")
cov <- as.matrix(read.table("pcangsd_n-amer-no-washington.cov"))
e <- eigen(cov)
df_e <- as.data.frame(e$vectors)

#### by year
ggplot(data=df_e,aes(x=V1,y=V2,color=info$year)) +
  geom_point() +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="Year", title="Individual Allele Frequency")

#### by long(or lat)
ggplot(data=df_e,aes(x=V1,y=V2,color=info$long)) +
  geom_point() +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="long", title="Individual Allele Frequency")

#### by instrument
ggplot(data=df_e,aes(x=V1,y=V2,color=info$instrument)) +
  geom_point() +
  scale_color_manual(values=c("#064061", "#56B4E9","#009E73","#E69F00","#9C4907")) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="Instrument", title="Individual Allele Frequency")

cols <- c("#064061", "#56B4E9","#009E73","#E69F00","#9C4907")
c(7,8,15:17)

#### by instrument and year
ggplot(data=df_e,aes(x=V1,y=V2,color=info$year)) +
  geom_point(size=2.3,aes(shape=info$instrument)) +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  scale_shape_manual(values=c(17,15,16,8,7)) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="Year", shape="Instrument", title="Individual Allele Frequency")


#length(unique(info$strat))
5