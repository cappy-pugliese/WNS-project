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

###########
# Genetic Data Processing
pruned_dosage <- vcf_to_dosage(ld_pruned_vcf)
rownames(pruned_dosage) <- sub("^(.*?_\\d+)_.*$", "\\1", rownames(pruned_dosage))

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

# performing a raster PCA
pca <- prcomp(NoA_bio)

##################
og_envpcs <- predict(NoA_bio, pca, index=1:3)

############ this line of code is what produces the map
# Single composite raster plot with 3 PCs 
#NoA_pca_map <- plotRGB(scaleRGB(og_envpcs),r=1,g=2,b=3)

# calculate environmental distances
env <- raster::extract(og_envpcs, coords_longlat)
#head(env)

env_dist <- env_dist(env)

# calculate geographic distance
geo_dist <- geo_dist(coords, type = "Euclidean")
# Make a fun heat map with the pairwise distances
geo_dist <- as.data.frame(geo_dist)
colnames(geo_dist) <- rownames(geo_dist)

##### genetic distance matrix 
gen_dist_packages()
euc_dists <- gen_dist(pruned_dosage, dist_type = "euclidean")