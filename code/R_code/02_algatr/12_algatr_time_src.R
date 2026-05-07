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
library(dplyr)

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr/")
raster_path = "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/climate_data/wc2.1_data"
#coords <- read.csv("NoA_Pd_coords.csv")
coords <- read.csv("no-washington_coords.csv")
#vcf <- read.vcfR("n-amer-no-clones_filtered.vcf")
ld_pruned_vcf <- read.vcfR("n-amer-no-washington_ploidy1_filtered_plink-ld.vcf")

###########
# Genetic Data Processing
pruned_dosage <- vcf_to_dosage(ld_pruned_vcf)
rownames(pruned_dosage) <- sub("^(.*?_\\d+)_.*$", "\\1", rownames(pruned_dosage))

###########
# Environmental data processing
envirodata_packages()
# coordniates
coords <- coords |> dplyr::select(x,y)
coords_longlat <- st_as_sf(x=coords, coords = c("x", "y"), crs = "+proj=longlat")
# load bioclimatic data
#bio <- worldclim_global(path=raster_path, var="bio", res=2.5)

## world map
North_America <- map_data("world") |> st_as_sf(coords = c("long","lat")) |> st_set_crs("+proj=longlat") |> filter(region == "Canada" | region == "USA")
NoA_rast <- rast(North_America)

# crop Raster* with Spatial* object
NoA <- as(extent(-96, -55, 25, 55), 'SpatialPolygons')
crs(NoA) <- crs(NoA_rast)
NoA_map <- crop(NoA_rast, NoA)
## this cropping did not work for some reason

# performing a raster PCA
#pca <- prcomp(NoA_bio, scale=TRUE)
# try to get the loadings
# value of rotation = the loadings (larger loadings)

##################

############ this line of code is what produces the map
# Single composite raster plot with 3 PCs 
#NoA_pca_map <- plotRGB(scaleRGB(og_envpcs),r=1,g=2,b=3)

# calculate environmental distances
#env <- raster::extract(og_envpcs, coords_longlat)
#head(env)

#env_dist <- env_dist(env)

# calculate geographic distance
geo_dist <- geo_dist(coords, type = "Euclidean")
# Make a fun heat map with the pairwise distances
geo_dist <- as.data.frame(geo_dist)
colnames(geo_dist) <- rownames(geo_dist)

##### genetic distance matrix 
gen_dist_packages()
euc_dists <- gen_dist(pruned_dosage, dist_type = "euclidean")

##### time pca
time_df <- read.csv("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr/26_05-07_no-wash_major-pop-and-time.csv")
time_df <- time_df |> dplyr::select(year)
pca_time <- prcomp(time_df, scale=TRUE)

#map_wtimepcs <- predict(NoA_map, pca_time)