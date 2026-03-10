############ load libraries
# base
import numpy as np
from importlib import resources #don't need after tutorial
from sklearn.impute import SimpleImputer
from pandas_plink import read_plink
import statsmodels.api as sm
import os

# viz
import matplotlib.pyplot as plt
import cartopy.crs as ccrs

# feems
from feems.utils import prepare_graph_inputs, cov_to_dist
from feems.objective import comp_mats
from feems.viz import draw_FEEMSmix_surface, plot_FEEMSmix_summary
from feems import SpatialGraph, Objective, Viz

# viz again
import cartopy.feature as cfeature

# change matplotlib fonts
plt.rcParams["font.family"] = "Arial"
plt.rcParams["font.sans-serif"] = "Arial"

############ set variables
data_path = '/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/07_feems'
feems_package_path ='/Users/caprinapugliese/.my-bin/miniconda3/envs/feems/lib/python3.12/site-packages/feems/data'

############ read in files
# read the genotype data and mean impute missing data
(bim, fam, G) = read_plink("{}/n-amer-no-washington_ploidy1_filtered_plink-ld".format(data_path))
imp = SimpleImputer(missing_values=np.nan, strategy="mean")
genotypes = imp.fit_transform((np.array(G)).T)

print("n_samples={}, n_snps={}".format(genotypes.shape[0], genotypes.shape[1]))

############ set up graph
# setup graph
coord = np.loadtxt("{}/no-washington_coords.txt".format(data_path))  # sample coordinates
grid_path = "{}/grid_100.shp".format(feems_package_path)  # path to discrete global grid

# graph input files
outer, edges, grid, _ = prepare_graph_inputs(coord=coord, 
                                             ggrid=grid_path,
                                             translated=True, 
                                             buffer=1)
############ making graph
plt.figure(dpi=200, figsize=(8,6))
projection = ccrs.AzimuthalEquidistant(central_longitude=-100)
ax = plt.axes(projection=projection)

# add coastlines, borders, and land features
ax.add_feature(cfeature.COASTLINE, edgecolor='#636363', linewidth=0.5)
ax.add_feature(cfeature.BORDERS, edgecolor='gray', linewidth=0.3)
ax.add_feature(cfeature.LAND, facecolor='#f7f7f7')

# add grid points
ax.scatter(grid[:, 0], grid[:, 1], s=3, color='grey', alpha=0.7, transform=ccrs.PlateCarree(), label='grid point')

# add outer boundary
ax.plot(outer[:, 0], outer[:, 1], color='black', linewidth=1, transform=ccrs.PlateCarree(), label='outer boundary')

# add edges
for edge in edges:
    i, j = edge - 1
    ax.plot([grid[i, 0], grid[j, 0]], [grid[i, 1], grid[j, 1]], 
            color='lightgray', linewidth=1, alpha=0.6, transform=ccrs.PlateCarree())

# add sample points
ax.scatter(coord[:, 0], coord[:, 1], s=8, color='black', zorder=2,transform=ccrs.PlateCarree(), label='sample points')
plt.legend()

############ SpatialGraph
sp_graph = SpatialGraph(genotypes, coord, grid, edges, scale_snps=True)
projection = ccrs.AzimuthalEquidistant(central_longitude=-100)

## making map
fig = plt.figure(dpi=300)
ax = fig.add_subplot(1, 1, 1, projection=projection)  
v = Viz(ax, sp_graph, projection=projection, edge_width=.5, 
        edge_alpha=1, edge_zorder=100, sample_pt_size=10, 
        obs_node_size=7.5, sample_pt_color="black", 
        cbar_font_size=10)
v.draw_map(longlat=True)
v.draw_samples()
v.draw_edges(use_weights=False)
v.draw_obs_nodes(use_ids=False)