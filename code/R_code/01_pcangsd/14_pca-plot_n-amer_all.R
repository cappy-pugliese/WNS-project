R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_tess_src.R"))

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

library(paletteer)
library(cowplot)

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist

## pcangsd tutorial
info <- read.csv("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd/26_04-20_n-amer-all_pops_df.csv")
info$year <- as.character(info$year)
cov <- as.matrix(read.table("pcangsd_n-amer-pd.cov"))
e <- eigen(cov)
evals = e$values/sum(e$values)
df_e <- as.data.frame(e$vectors)

## pca differences chart
pc_percents <- as.data.frame(evals)
pc_percents$number <- c(1:55)
ggplot(data=pc_percents,aes(y=evals, x=number)) + geom_point() + theme_cowplot()

###########################
## by pca groups
cols <- c("#E69F00","#56B4E9","#064061")
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2", "Lab clones")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "PCA Groups")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2", "Lab clones")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "PCA Groups")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2", "Lab clones")) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "PCA Groups")

###########################
## by year
cols2 <- c("#064061", "#0072B2", "#56B4E9", "#81BFAE", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907")
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$year)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "Year")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$year)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "Year")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$year)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "Year")

###########################
## by pop
cols3 <- c("#064061", "#0072B2", "#56B4E9", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907")
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$Pop)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values = cols3) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "PCAngsd Pop")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$Pop)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values = cols3) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "PCAngsd Pop")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$Pop)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols3) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "PCAngsd Pop")