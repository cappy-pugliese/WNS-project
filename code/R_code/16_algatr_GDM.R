R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/"
source(paste0(R_code_path, "12_algatr_src.R"))
plot_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/graphs/02_algatr/03_gdm/"

#libraries
gdm_packages()
library(gdm)


NoA_env <- raster::stack(og_envpcs)
env <- raster::extract(NoA_env, coords)

gdm_full <- gdm_run(
  gendist = euc_dists,
  coords = coords,
  env = env,
  model = "full",
  scale_gendist = TRUE
)

gdm_plot_diss(gdm_full$model)

# Plot the I-splines with free x and y-axes
gdm_plot_isplines(gdm_full$model, scales = "free")
gdm_plot_isplines(gdm_full$model, scales = "free_x")
# does not work
  # Warning message:
    # Removed 2000 rows containing missing values or values outside the scale range (`geom_line()`). 


# To run gdm.varImp() you need a gdmData object, which you can create using gdm_format()
gdmData <- gdm_format(euc_dists, coords, env, scale_gendist = TRUE)
# Then you can run gdm.varImp(), specifying whether you want to use geographic distance as a variable as well as the number of permutations you wish to run
varimp <- gdm.varImp(gdmData, geo = TRUE, nPerm = 50)
# You can visualize the results using gdm_varimp_table()
gdm_varimp_table(varimp)


map <- gdm_map(gdm_full$model, NoA_env, coords)

# Extract the GDM map from the GDM model object
maprgb <- map$pcaRastRGB

# Now, use `extrap_mask()` to do buffer-based masking 
# (i.e., mask out areas outside a buffer around our sampling coordinates)
map_mask <- extrap_mask(liz_coords, maprgb, method = "buffer", buffer_width = 1.25)




###################################################
#### saving graphs: 
###################################################
date <- "26_02-11"
plot_title <- "05_map"
paste0(date, "_gdm_", plot_title)
png(file=paste0(plot_path, date, "_gdm_", plot_title),width=620, height=450)
plot
dev.off()