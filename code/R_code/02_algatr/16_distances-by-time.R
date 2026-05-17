## distance matricies
spatial_distance <- as.matrix(geo_dist)
gen_distance <- as.matrix(euc_dists)

time_dists <- as.matrix(gen_dist(time_df, dist_type = "euclidean"))

## pca vectors


## spatial regression model