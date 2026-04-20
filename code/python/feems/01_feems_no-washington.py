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
import cartopy.feature as cfeature

# feems
from feems.utils import prepare_graph_inputs, cov_to_dist
from feems.objective import comp_mats
from feems.viz import draw_FEEMSmix_surface, plot_FEEMSmix_summary
from feems import SpatialGraph, Objective, Viz

# change matplotlib fonts
plt.rcParams["font.family"] = "Arial"
plt.rcParams["font.sans-serif"] = "Arial"

############ set variables
data_path = '/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/07_feems'
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


############ fit feems ############
### from cross validation:
## lamb = 2.15
## lamb_q = 1.00

sp_graph.fit(lamb = 2.15, lamb_q = 1.00, optimize_q = 'n-dim')

fig = plt.figure(dpi=300)
ax = fig.add_subplot(1, 1, 1, projection=projection)  
v = Viz(ax, sp_graph, projection=projection, edge_width=.5, 
        edge_alpha=1, edge_zorder=100, sample_pt_size=20, 
        obs_node_size=7.5, sample_pt_color="black", 
        cbar_font_size=10)
v.draw_map()
v.draw_edges(use_weights=True)
v.draw_obs_nodes(use_ids=False) 
v.draw_edge_colorbar()


## feems fit plot
# creating an obj 
obj = Objective(sp_graph); obj.inv(); obj.grad(reg=False)
# computing distances matrice for fit (expected) vs empirical (observed) 
fit_cov, _, emp_cov = comp_mats(obj)
# subsetting matrices to arrays 
fit_dist = cov_to_dist(fit_cov)[np.tril_indices(sp_graph.n_observed_nodes, k=-1)]
emp_dist = cov_to_dist(emp_cov)[np.tril_indices(sp_graph.n_observed_nodes, k=-1)]

# fitting a linear model to the observed distances
X = sm.add_constant(fit_dist)
mod = sm.OLS(emp_dist, X)
res = mod.fit()
muhat, betahat = res.params

## plot
plt.figure(dpi=100)
plt.plot(fit_dist, emp_dist, 'o', color='k', alpha=0.8, markersize=4)
plt.axline((0.5,0.5*betahat+muhat), slope=betahat, color='orange', ls='--', lw=3)
plt.text(5, 0.5, "R²={:.3f}".format(res.rsquared), fontsize=15)
plt.xlabel('Fitted distance'); plt.ylabel('Genetic distance')
plt.title(r"$\tt{FEEMS}$ fit with estimated node-specific variances")


############################
### left off at fit FEEMSmix
############################

# choose a specified level 
outliers_df = sp_graph.extract_outliers(0.01)

# visualizing the outlier demes on the map
fig = plt.figure(dpi=200)
ax = fig.add_subplot(1, 1, 1, projection=projection)  
v = Viz(ax, sp_graph, projection=projection, edge_width=.5, 
        edge_alpha=1, edge_zorder=100, sample_pt_size=20, 
        obs_node_size=7.5, sample_pt_color="black", 
        cbar_font_size=10)
v.draw_map(); v.draw_edges(use_weights=False)
# ~NEW~ function
v.draw_outliers(outliers_df)
# using deme IDs since all results will be represented with these numbers
v.draw_obs_nodes(use_ids=True)

# recommended to start with K=10 (nedges is K)
# originally ran with 10, going to try running it with actual pcangsd k value of 7
seq_results = sp_graph.sequential_fit(
    outliers_df=outliers_df, 
    lamb=2.15, lamb_q=1.0, optimize_q='n-dim', 
    nedges=7, top=5
)

# visualizing the LREs as arrows
fig = plt.figure(dpi=250)
ax = fig.add_subplot(1, 1, 1, projection=projection)  
v = Viz(ax, sp_graph, projection=projection, edge_width=.5, 
        edge_alpha=1, edge_zorder=100, sample_pt_size=20, 
        obs_node_size=7.5, sample_pt_color="black", 
        cbar_font_size=10)
v.draw_map(); v.draw_edges(use_weights=True); v.draw_obs_nodes()
v.draw_LREs(seq_results)#; v.draw_edge_colorbar(); v.draw_c_colorbar()

plot_FEEMSmix_summary(seq_results, sequential=True)

######## just the bars
#bars = Viz(ax, sp_graph, projection=projection, edge_width=.5, 
 #       edge_alpha=1, edge_zorder=100, sample_pt_size=20, 
  #      obs_node_size=0, sample_pt_color="black", 
   #     cbar_font_size=10)
#bars.draw_map();bars.draw_edge_colorbar(); bars.draw_c_colorbar()

#plot_FEEMSmix_summary(seq_results, sequential=True)

#############################################################################
# moving to R for mapping

# write the relevant edge weights out into a csv file
np.savetxt('edgew.csv', np.vstack((np.array(sp_graph.edges).T, sp_graph.w)).T, delimiter=',')

# write the deme coordinates + sample size (node attributes) out into a csv file
np.savetxt('nodepos.csv', np.vstack((sp_graph.node_pos.T, [sp_graph.nodes[n]['n_samples'] for n in range(len(sp_graph.nodes))])).T, delimiter=',')

# (if using `FEEMSmix`,` print the MLE source & admix. prop.)
contour_df = sp_graph.calc_joint_contour(...) 
print(contour_df.iloc[np.argmax(contour_df['scaled log-lik'])])