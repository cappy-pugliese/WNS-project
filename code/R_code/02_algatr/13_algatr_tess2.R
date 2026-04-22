R_code_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
pcangsd_data_path <- "/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/"
pd_info <- read.csv(paste0(pcangsd_data_path, "25_12-10_n-amer-no-clones_locations.csv"))

source(paste0(R_code_path, "12_tess_src.R"))
setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/")

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

df_qmat <- as.data.frame(qmat)
colnames(df_qmat) <- c("K2","K3","K1")
df_qmat <- df_qmat |> dplyr::relocate(K1, K2, K3)
qmat2 <- as.matrix(df_qmat)

krig_admix <- tess_krig(qmat2, coords_longlat, krig_raster)

## bar plot of Q values, k=3
#tess_ggbarplot(qmat)
df_qmat <- as.data.frame(qmat)
colnames(df_qmat) <- c("K1","K2","K3")
df_qmat$Sample <- rownames(pruned_dosage)
df_qmat$year <- pd_info$year
df_qmat <- df_qmat |> dplyr::relocate(Sample, year, K1, K2, K3)
df_long_qmat <- df_qmat |> pivot_longer(cols=c('K1','K2','K3'),
                            names_to = 'K_value',
                            values_to = 'Q_value')
## color scheme
colors <- c("#ea7820","#0072B2", "#e5d827")
## plot
plot1 <- ggplot(df_long_qmat,aes(x=Sample,y=Q_value,fill=K_value)) +
scale_fill_manual(values = colors) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.7, 'cm'),axis.title = element_text(size = 14), legend.text = element_text(size = 12), legend.title = element_text(size = 14)) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid( ~ year, scales = "free_x", space="free_x", switch = "x") +
labs(x = "Individuals by Year", y = "Ancestry Q value\n(Admixture Proportion)", fill = "K values") 
plot1

## color scheme
colors <- c("#d62e00","#0072B2", "#fff023")
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