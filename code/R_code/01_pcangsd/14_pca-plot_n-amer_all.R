R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_tess_src.R"))

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

library(paletteer)
library(cowplot)

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist


## pcangsd tutorial
#info <- read.csv("26_02-23_n-amer-no-washington_pca-info.csv")
cov <- as.matrix(read.table("pcangsd_n-amer-pd.cov"))
e <- eigen(cov)
evals = e$values/sum(e$values)
df_e <- as.data.frame(e$vectors)

###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2)) +
  geom_point(alpha=0.5,size=2.5) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""))

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3)) +
  geom_point(alpha=0.5,size=2.5) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""))