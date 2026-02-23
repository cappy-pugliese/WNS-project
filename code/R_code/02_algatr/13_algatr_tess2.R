R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
pcangsd_data_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/"

source(paste0(R_code_path, "12_algatr_src.R"))
setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")

##### tess tutorial
## https://thewanglab.github.io/algatr/articles/TESS_vignette.html

## load tess libraires
tess_packages()
library(here)
library(wingen)
library(tess3r)
library(fields)
library(rworldmap)
library(automap)
library(cowplot)

#my libraries
library(patchwork)

## color scheme
colors <- c("#D55E00", "#0072B2", "#DACE1E")

## begin tess
krig_raster <- raster::aggregate(og_envpcs, fact = 6)

tess3_result <- tess_ktest(pruned_dosage, coords, Kvals = 1:10, ploidy = 2, K_selection = "auto")
# predicts k-value to be 3
# different from pcangsd (k-value = 7)

tess3_obj <- tess3_result$tess3_obj
bestK <- tess3_result[["K"]]
# Get Qmatrix with ancestry coefficients
qmat <- qmatrix(tess3_obj, K = bestK)

coords_longlat <- st_transform(coords_longlat, crs = 3857)
krig_raster <- terra::project(krig_raster, "epsg:3857")


krig_admix <- tess_krig(qmat, coords_longlat, krig_raster)

## bar plot of Q values, k=3
tess_ggbarplot(qmat)

### plotting using tess
tessplot <- tess_ggplot(krig_admix,
  plot_method = "maxQ", minQ = 0.2,
  ggplot_fill = scale_fill_manual(values = colors),
  plot_axes = TRUE, 
  coords = coords_longlat,
  list = TRUE)

tessplot$plot + tessplot$legend
# legend = ancestry coefficient (Q) vs k value
tessplot_poly_maxQ <- tess_ggplot(krig_admix,
  plot_method = "maxQ_poly", minQ = 0.20,
  ggplot_fill = scale_fill_manual(values = colors),
  plot_axes = TRUE, 
  coords = coords_longlat,
  list = TRUE)

tessplot_poly_maxQ

tessplot_poly_allQ <- tess_ggplot(krig_admix,
  plot_method = "allQ_poly", minQ = 0.20,
  ggplot_fill = scale_fill_manual(values = colors),
  plot_axes = TRUE, 
  coords = coords_longlat,
  list = TRUE)

tessplot_poly_allQ