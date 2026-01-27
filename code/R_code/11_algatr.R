library(raster)
library(sp)
library(geodata)
library(algatr)
library(vcfR)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr/")
raster_path = "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/climate_data/wc2.1_data"
coords <- read.csv("NoA_Pd_coords.csv")
vcf <- read.vcfR("n-amer-no-clones_filtered.vcf")
ld_pruned_vcf <- read.vcfR("n-amer-no-clones_ploidy1_filtered_plink-ld.vcf")

# load bioclimatic data
bio <- worldclim_global(path=raster_path, var="bio", res=2.5)

# crop Raster* with Spatial* object
NoA <- as(extent(-135, -55, 25, 60), 'SpatialPolygons')
crs(NoA) <- crs(bio)
NoA_bio <- crop(bio, NoA)
# plot(NoA_bio[[12]])

## https://stackoverflow.com/questions/75739085/running-a-pca-on-a-rasterstack-in-r
## pca code
pca <- prcomp(NoA_bio)
x <- predict(NoA_bio, pca)
# plot(x)

NoA_pca_map <- plotRGB(scaleRGB(x),r=1,g=2,b=3)


####
do_everything_for_me(Pd_vcf, coords, NoA_pca_map)
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

# Genetic Data Processing
dosage <- vcf_to_dosage(vcf)
pruned_dosage <- vcf_to_dosage(ld_pruned_vcf)

#k = 7
#str_dos <- str_impute(gen = dosage, K = 7, entropy = TRUE, repetitions = 3, quiet = FALSE, save_output = FALSE)
# ^neither code worked
  # there was something wrong with the NA's
    # Error in `.f()`:
    # ! Missing data must be encoded as 9.
simple_dos <- simple_impute(dosage)
# ^this one works

# ld prune function still doesn't work, even with using dosage variable instead
# so just going to stick with using the plink ld prune vcf file
# it also doesn't have na's, so I don't have to worry about that either

# Environmental data processing



# genetic distances

###################################

# TESS
tess_packages()
ld_pruned_vcf <- read.vcfR("n-amer-no-clones_ploidy1_filtered_plink-ld.vcf")


