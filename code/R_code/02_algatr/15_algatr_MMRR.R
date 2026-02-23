R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr"
source(paste0(R_code_path, "12_algatr_src.R"))

#libraries
mmrr_packages()
library(here)

Y <- as.matrix(euc_dists)
X <- as.matrix(env_dist)
X[["geodist"]] <- geo_dist(coords_longlat)

results_full <- mmrr_run(Y, X, nperm = 99, stdz = TRUE, model = "full")
results_best <- mmrr_run(Y, X, nperm = 99, stdz = TRUE, model = "best")
# x-axis is the environmental distance
# y-axis is the genetic distance

mmrr_plot(Y, X, mod = results_full$mod, plot_type = "all", stdz = TRUE)
# the fitted graph has wonky x axisL all of the predicted genetic distances are zero for some reason
# the other plots are identical to the results_best graphs
mmrr_table(results_full, digits = 2, summary_stats = TRUE)
#Warning messages:
#1: In min(mmrr_df$estimate) :
#  no non-missing arguments to min; returning Inf
#2: In max(mmrr_df$estimate) :
#  no non-missing arguments to max; returning -Inf
#Error in `scales::col_numeric()`:
#! Wasn't able to determine range of `domain`

mmrr_plot(Y, X, mod = results_best$mod, plot_type = "all", stdz = TRUE)
mmrr_table(results_best, digits = 2, summary_stats = TRUE)

mmrr_full_everything <- mmrr_do_everything(euc_dists, coords_longlat, env = og_envpcs, geo = TRUE, model = "full")