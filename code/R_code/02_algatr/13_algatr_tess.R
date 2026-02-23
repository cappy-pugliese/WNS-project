R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
pcangsd_data_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/"

source(paste0(R_code_path, "12_algatr_src.R"))
setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")
pd_info <- read.csv(paste0(pcangsd_data_path, "25_12-10_n-amer-no-clones_locations.csv"))

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
colors <- c("#0072B2", "#D55E00", "#DACE1E")

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

df_qmat <- as.data.frame(qmat)
colnames(df_qmat) <- c("K3","K1","K2")
df_qmat$Sample <- rownames(pruned_dosage)
df_qmat$year <- pd_info$year
df_qmat <- df_qmat |> dplyr::relocate(Sample, year, K1, K2, K3)
df_long_qmat <- df_qmat |> pivot_longer(cols=c('K1','K2','K3'),
                            names_to = 'K_value',
                            values_to = 'Q_value')


plot1 <- ggplot(df_long_qmat,aes(x=Sample,y=Q_value,fill=K_value)) +
scale_fill_manual(values = colors) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.5, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid( ~ year, scales = "free_x", space="free_x", switch = "x") +
labs(title = "LD Pruned North American Pd Samples", x = "Individuals by Year", y = "Q Value") 
plot1

## bar plot of Q values, k=7
#tess3_obj_K7 <- tess3(pruned_dosage, coord = as.matrix(coords), K = 7, method = "projected.ls", ploidy = 2)
#pcangsd_k <- 7
#qmat_k7 <- qmatrix(tess3_obj_K7, K = pcangsd_k)
#tess_ggbarplot(qmat_k7)

### plotting using tess
tessplot <- tess_ggplot(krig_admix,
  plot_method = "maxQ", minQ = 0.2,
  ggplot_fill = scale_fill_manual(values = colors),
  plot_axes = TRUE, 
  coords = coords_longlat,
  list = TRUE)

tessplot$plot + tessplot$legend
# legend = ancestry coefficient (Q) vs k value
tessplot_poly <- tess_ggplot(krig_admix,
  plot_method = "allQ_poly", minQ = 0.20,
  ggplot_fill = scale_fill_manual(values = colors),
  plot_axes = TRUE, 
  coords = coords_longlat,
  list = TRUE)

tessplot_poly
 
par(mfrow = c(2, 2), mar = (c(1, 4, 1, 4) + 0.1), oma = rep(1, 4), mai = c(1,1,1,1))
tess_plot_allK(krig_admix, col_breaks = 20, legend.width = 2)

#dev.off()
# ^ will reset par() function


## attempting to use base(?) tess
#coords_proj_mat <- st_coordinates(coords_longlat)
#plot(qmat,
#  coords_proj_mat,
#  method = "map.max",
#  interpol = FieldsKrigModel(10),
#  main = "Ancestry coefficients",
#  xlab = "x", ylab = "y",
#  col.palette = CreatePalette(),
#  resolution = c(300, 300), cex = .4
#)
# oh hey it worked just using base tess