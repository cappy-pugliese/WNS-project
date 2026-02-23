library(raster)
library(sp)
library(geodata)
library(algatr)
library(vcfR)
library(sf)
library(viridis)
#library(RStoolbox)
library(terra)
library(ggplot2)
library(tidyr)
library(tibble)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr/")
raster_path = "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/climate_data/wc2.1_data"
coords <- read.csv("NoA_Pd_coords.csv")
#vcf <- read.vcfR("n-amer-no-clones_filtered.vcf")
ld_pruned_vcf <- read.vcfR("n-amer-no-clones_ploidy1_filtered_plink-ld.vcf")

###################################

#do_everything_for_me(Pd_vcf, coords, NoA_pca_map)
#Please be aware: the do_everything functions are meant to be exploratory. We do not recommend their use for final analyses unless certain they are properly parameterized.
#Loading required namespace: adegenet
#Registered S3 method overwritten by 'ecodist':
#  method   from 
#  dim.dist proxy
#Warning message:
#In gen_dist(gen, dist_type = "euclidean") :
#  NAs found in genetic data, imputing to the median (NOTE: this simplified imputation approach is strongly discouraged. Consider using another method of removing missing data)
#Error:
#! vector memory limit of 16.0 Gb reached, see mem.maxVSize()

### looks like my computer does not have enough memory to run this lol

###################################

###########
# Genetic Data Processing
#dosage <- vcf_to_dosage(vcf)
pruned_dosage <- vcf_to_dosage(ld_pruned_vcf)
rownames(pruned_dosage) <- sub("^(.*?_\\d+)_.*$", "\\1", rownames(pruned_dosage))

#k = 7
#str_dos <- str_impute(gen = dosage, K = 7, entropy = TRUE, repetitions = 3, quiet = FALSE, save_output = FALSE)
# ^neither code worked
  # there was something wrong with the NA's
    # Error in `.f()`:
    # ! Missing data must be encoded as 9.
#simple_dos <- simple_impute(dosage)
# ^this one works
# ld prune function still doesn't work, even with using dosage variable instead
# so just going to stick with using the plink ld prune vcf file
# it also doesn't have na's, so I don't have to worry about that either

###########
# Environmental data processing
envirodata_packages()
# coordniates
coords_longlat <- st_as_sf(x=coords, coords = c("x", "y"), crs = "+proj=longlat")
# load bioclimatic data
bio <- worldclim_global(path=raster_path, var="bio", res=2.5)
# crop Raster* with Spatial* object
NoA <- as(extent(-135, -55, 25, 60), 'SpatialPolygons')
crs(NoA) <- crs(bio)
NoA_bio <- crop(bio, NoA)
# make map (biovariable 1) with points
plot(NoA_bio[[1]], col = turbo(100), axes = FALSE)
points(coords_longlat, pch = 19)

# checking collinearity among environmental layers
  #cors_env <- check_env(NoA_bio)
# checking collinearity of extracted environmental values at each coordinate
  #check_result <- check_vals(NoA_bio, coords_longlat)
# checking collinearity between distances
  #check_results <- check_dists(NoA_bio, coords_longlat)

# performing a raster PCA
#######################################
# tutorial: https://thewanglab.github.io/algatr/articles/enviro_data_vignette.html
#######################################
### from a different tutorial:
## https://stackoverflow.com/questions/75739085/running-a-pca-on-a-rasterstack-in-r
## pca code
pca <- prcomp(NoA_bio)
##################
### plotting pca data
# https://www.geeksforgeeks.org/r-language/prcomp-in-r/
pca_data <- data.frame(
  Component = 1:length(pca$sdev),
  Variance = pca$sdev^2 / sum(pca$sdev^2)
)

scree_plot <- ggplot(pca_data, aes(x = Component, y = Variance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_line() +
  geom_point() +
  xlab("Principal Components") +
  ylab("Proportion of Variance Explained") +
  ggtitle("Scree Plot")
##################
og_envpcs <- predict(NoA_bio, pca, index=1:3)

cors_pca_env <- check_env(og_envpcs)
check_result <- check_vals(og_envpcs, coords_longlat)
check_results <- check_dists(og_envpcs, coords_longlat)
  # Warning: The distances for 6 pairs of variables are significantly correlated
  # PC 1 and PC 3 seem to be on the higher side (r ~ 0.65)

# Single composite raster plot with 3 PCs 
#NoA_pca_map <- ggRGB(og_envpcs, 1, 2, 3, stretch = "lin", q = 0, geom_raster = TRUE)
NoA_pca_map <- plotRGB(scaleRGB(og_envpcs),r=1,g=2,b=3)

# calculate environmental distances
env <- raster::extract(og_envpcs, coords_longlat)
#head(env)

env_dist <- env_dist(env)
plot(env_dist$PC1)
plot(env_dist$PC2)
plot(env_dist$PC3)

# needs tidyr & tibble libraries
as.data.frame(env_dist$PC1) %>%
  rownames_to_column("sample") %>%
  pivot_longer(-"sample", names_to = "sample_comp", values_to = "dist") %>%
  ggplot(aes(x = as.numeric(sample), y = as.numeric(sample_comp), fill = dist)) +
  geom_tile() +
  coord_equal() +
  scale_fill_viridis() +
  xlab("Sample") +
  ylab("Sample")

# calculate geographic distance
geo_dist <- geo_dist(coords, type = "Euclidean")
plot(geo_dist)
# Make a fun heat map with the pairwise distances
geo_dist <- as.data.frame(geo_dist)
colnames(geo_dist) <- rownames(geo_dist)
geo_dist %>%
  rownames_to_column("sample") %>%
  gather("sample_comp", "dist", -"sample") %>%
  ggplot(aes(x = as.numeric(sample), y = as.numeric(sample_comp), fill = dist)) +
  geom_tile() +
  coord_equal() +
  scale_fill_viridis() +
  xlab("Sample") +
  ylab("Sample")

###########
# genetic distances
#https://thewanglab.github.io/algatr/articles/gen_dist_vignette.html
###################################
gen_dist_packages()
library(cowplot)
################################### genetic distance matrix ###################################
euc_dists <- gen_dist(pruned_dosage, dist_type = "euclidean")
gen_dist_hm(euc_dists) + 
  scale_fill_viridis() +
  labs(title="Genetic Distances (Euclidean)")

#dps_dists <- gen_dist(vcf, dist_type = "dps")
#gen_dist_hm(dps_dists) + 
 # scale_fill_viridis() +
  #labs(title="Genetic Distances (DPS)")



