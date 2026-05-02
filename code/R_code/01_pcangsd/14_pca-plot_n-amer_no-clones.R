R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_tess_src.R"))

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

library(paletteer)
library(cowplot)

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist

## pcangsd tutorial
info <- read.csv("26_04-20_n-amer-no-clones_df.csv")
info$year <- as.character(info$year)
cov <- as.matrix(read.table("pcangsd_n-amer-no-clones.cov"))
e <- eigen(cov)
evals = e$values/sum(e$values)
df_e <- as.data.frame(e$vectors)

## pca differences chart
pc_percents <- as.data.frame(evals)
pc_percents$number <- c(1:51)
ggplot(data=pc_percents,aes(y=evals, x=number)) + geom_point() + theme_cowplot()

###########################
## by pca groups
cols <- c("#E69F00","#064061")
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "PCA Groups")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "PCA Groups")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$pca_groups)) +
  geom_point(alpha=0.6,size=2.5) +
  scale_color_manual(values = cols, labels=c("Group1", "Group2")) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "PCA Groups")

###########################
## by year
cols2 <- c("#064061", "#0072B2", "#56B4E9", "#81BFAE", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907")
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$year)) +
  geom_point(size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "Year")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$year)) +
  geom_point(size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "Year")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$year)) +
  geom_point(size=2.5) +
  scale_color_manual(values = cols2) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "Year")

###########################
## latitude - for 2012 and 2013 only
###### PC1 vs PC2
df_e_and_info <- bind_cols(info, df_e) |> select(ind, country, state, year, Pop, pca_groups, long, lat, V1, V2, V3, V4)
same_year_2012 <- df_e_and_info |> filter(year=="2012" | year=="2013")
ggplot(data=same_year_2012,aes(x=V1,y=V2, color=lat)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "Latitude")

##### PC2 vs PC3
ggplot(data=same_year_2012,aes(x=V2,y=V3, color=lat)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "Latitude")

##### PC3 vs PC4
ggplot(data=same_year_2012,aes(x=V3,y=V4, color=lat)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "Latitude")

###########################
## longitude
###### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2, color=info$long)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "Longitude")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3, color=info$long)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "Longitude")

##### PC3 vs PC4
ggplot(data=df_e,aes(x=V3,y=V4, color=info$long)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "Longitude")

###########################
## state
#df_e_and_info_states <- df_e_and_info |> arrange(lat,long) |> group_by(state)
#write.csv(df_e_and_info_states,file="26_05-01_states-info.csv",row.names=FALSE,quote=FALSE)
df_e_and_info_states <- read.csv("26_05-01_states-info.csv")
###### PC1 vs PC2
ggplot(data=df_e_and_info_states,aes(x=V1,y=V2, color=state_groups)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color = "States\n(ranked by\nlong & lat)")

##### PC2 vs PC3
ggplot(data=df_e_and_info_states,aes(x=V2,y=V3, color=state_groups)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color = "States\n(ranked by\nlong & lat)")

##### PC3 vs PC4
ggplot(data=df_e_and_info_states,aes(x=V3,y=V4, color=state_groups)) +
  geom_point(size=2.5) +
  scale_colour_continuous(palette = c("#064061", "#0072B2", "#56B4E9", "#DACE1E","#E69F00","#D55E00","#9C4907")) +
  theme_cowplot() +
  labs(x = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), y = paste("PC4 (",round(evals[4]*100,2),"%)",sep=""), color = "States\n(ranked by\nlong & lat)")