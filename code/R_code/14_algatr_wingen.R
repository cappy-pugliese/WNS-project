R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/"
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

kgd <- krig_gd(wgd, index = 1:2, pd_lyr, disagg_grd = 5)