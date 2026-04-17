R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_algatr_src.R"))

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

library(paletteer)

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist


## pcangsd tutorial
info <- read.csv("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/26_02-25_only-pd_info.csv")
cov <- as.matrix(read.table("pcangsd_only-pd.cov"))
e <- eigen(cov)
evals = e$values/sum(e$values)
df_e <- as.data.frame(e$vectors)

#### by year
ggplot(data=df_e,aes(x=V1,y=V2,color=info$year)) +
  geom_point(size=2.5) +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color="Year", title="Individual Allele Frequency")

#### by long(or lat)
ggplot(data=df_e,aes(x=V1,y=V2,color=info$long)) +
  geom_point(size=2.5) +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color="long", title="Individual Allele Frequency")

ggplot(data=df_e,aes(x=V1,y=V2,color=info$lat)) +
  geom_point(size=2.5) +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color="lat", title="Individual Allele Frequency")

#### by continent
##### PC1 vs PC2
ggplot(data=df_e,aes(x=V1,y=V2,color=info$continent)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values=c("#56B4E9","#064061","#D55E00"), labels=c("Asia","Europe","North America")) +
  theme_cowplot() +
  labs(x = paste("PC1 (",round(evals[1]*100,2),"%)",sep=""), y = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), color="Continent") #title="Individual Allele Frequency")

##### PC2 vs PC3
ggplot(data=df_e,aes(x=V2,y=V3,color=info$continent)) + #label=info$individuals)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values=c("#56B4E9","#064061","#D55E00"), labels=c("Asia","Europe","North America")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color="Continent") #title="Individual Allele Frequency") #+
  #geom_text(hjust=0, vjust=0)

#### by instrument
ggplot(data=df_e,aes(x=V1,y=V2,fill=info$instrument)) +
  geom_point(aes(alpha=0.5),shape=21,color="black", size=2.5) +
  scale_fill_manual(values=c("#064061", "#56B4E9","#009E73","#FDF17B","#E69F00","#9C4907")) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", fill="Instrument", title="Individual Allele Frequency")

ggplot(data=df_e,aes(x=V1,y=V2,fill=info$instrument)) +
  geom_point(shape=21,color="black",size=2.5) +
  scale_fill_manual(values=c("#064061", "#56B4E9","#009E73","#FDF17B","#E69F00","#9C4907")) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", fill="Instrument", title="Individual Allele Frequency")

#### by strat
ggplot(data=df_e,aes(x=V1,y=V2,color=info$strat)) +
  geom_point(aes(alpha=0.5),size=2.5) +
  scale_color_manual(values=c("#56B4E9","#D55E00")) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="Strat", title="Individual Allele Frequency")

#### by instrument and year
ggplot(data=df_e,aes(x=V1,y=V2,color=info$year)) +
  geom_point(size=2.3,aes(shape=info$instrument)) +
  scale_colour_paletteer_c("grDevices::Zissou 1") +
  scale_shape_manual(values=c(0:5)) +
  theme_cowplot() +
  labs(x = "PC1", y = "PC2", color="Year", shape="Instrument", title="Individual Allele Frequency")


#length(unique(info$strat))
5

pc_percents <- as.data.frame(evals)
pc_percents$number <- c(1:67)
ggplot(data=pc_percents,aes(y=evals, x=number)) + geom_point()

ggplot(data=df_e,aes(x=V2,y=V3,color=info$continent, label=info$individuals)) +
  geom_point(alpha=0.5,size=2.5) +
  scale_color_manual(values=c("#56B4E9","#064061","#D55E00"), labels=c("Asia","Europe","North America")) +
  theme_cowplot() +
  labs(x = paste("PC2 (",round(evals[2]*100,2),"%)",sep=""), y = paste("PC3 (",round(evals[3]*100,2),"%)",sep=""), color="Continent") +
  geom_text(hjust=0, vjust=0)