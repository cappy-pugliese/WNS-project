R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_algatr_src.R"))

#libraries
wingen_packages()
library(wingen)

#### wingen tutorial
# Next, the coordinates and raster can be projected to an equal area projection, in this case the Goode Homolosine projection (https://proj.org/operations/projections/goode.html):
coords_eq <- st_transform(coords_longlat, crs = "+proj=goode") 

#### algatr wingen tutorial
# Aggregate the layer so plotting is a bit faster
envlayer <- raster::aggregate(og_envpcs$PC1, fact = 5)
# Reproject to same crs as the projected coordinates
envlayer <- project(envlayer, "+proj=goode")

pd_lyr <- coords_to_raster(coords_eq, res = 50000, buffer = 5, plot = TRUE)

#sample_count <- preview_gd(pd_lyr, coords_eq, wdim = 7, fact = 0)
#ggplot_count(sample_count)

wgd <- window_gd(ld_pruned_vcf,
  coords_eq,
  pd_lyr,
  stat = "pi",
  wdim = 7,
  fact = 0
)

# Plot map of pi
ggplot_gd(wgd, bkg = envlayer) + ggtitle("Moving window pi")

#setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr")
#kgd <- terra::rast("wingen_kgd_no-washington.tif")
kgd <- krig_gd(wgd, index = 1:2, pd_lyr, disagg_grd = 5)
# worked, but also produced warnings + took long time
# Warning messages:
  #1: `krig_gd()` was deprecated in wingen 2.2.0. ℹ Please use `wkrig_gd()` instead. This warning is displayed once per session. Call lifecycle::last_lifecycle_warnings() to see where this warning was generated. 
  #2: In sqrt(krige_result$var1.var) : NaNs produced
  #3: In sqrt(krige_result$var1.var) : NaNs produced
setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr")
# S4 method for class 'SpatRaster,character'
writeRaster(kgd, "wingen_kgd_no-washington.tif", overwrite=FALSE)

# Plot kriged map of pi
ggplot_gd(kgd) + ggtitle("Kriged pi")

# Plot kriged sample count map
ggplot_count(kgd) + ggtitle("Kriged sample counts")

# adding a mask using sample counts
mgd_1 <- mask_gd(kgd, kgd[["sample_count"]], minval = 1)
ggplot_gd(mgd_1, bkg = envlayer) + ggtitle("Kriged & masked pi")


# mask using boundary raster file
## Resample envlayer based on masked layer
r <- terra::resample(envlayer, mgd_1)

## Perform masking
mgd <- mask_gd(mgd_1, r)

## Plot masked map
ggplot_gd(mgd, bkg = envlayer) + ggtitle("Kriged & masked pi")