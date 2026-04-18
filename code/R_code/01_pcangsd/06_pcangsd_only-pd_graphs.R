library(ggplot2)
library(see)
library(dplyr)
#library(colorblindr)

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_12-09_only-pd_pcangsd_longdf.csv")
df_continent <- df_long |> group_by(continent) |> arrange(.by_group = TRUE)

cols <- c("#064061", "#0072B2", "#56B4E9", "#B4E1FB", "#81BFAE", "#009E73","#DACE1E","#FDF17B","#FFD534","#E69F00","#D55E00","#9C4907","#CC79A7","#F5A9D3","#FFDBEF")


# og graph
pd_ind <- ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_manual(values = rev(cols)) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.5, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
labs(title = "Only Pd Samples: PCAngsd Admixture", x = "Individuals", y = "Admix") 
pd_ind
# cvd_grid(pd_ind)
# to check colors with different colorblind types

continents_label <- c(
  `Asia` = "Asia",
  `Europe` = "Europe",
  `N_America` = "North America"
)

## grouped by continent graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_manual(values = rev(cols)) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid( ~ continent, scales = "free_x", space="free_x", switch = "x", labeller = as_labeller(continents_label)) +
labs(title = "Only Pd Samples: by Continent", x = "Individuals", y = "Admix")


####################################
# results calculations stuff
####################################

pop11 <- df_long |> filter(Pop == "pop11") 
pop11_2 <- pop11 |> filter(ind != "Pd_02", ind != "Pd_58", ind != "Pd_59")

pop11_2_namer <- pop11_2 |> filter(continent == "N_America")
summary(pop11_2_namer$admix)

pop11_namer <- pop11 |> filter(continent == "N_America") |> filter(ind == "Pd_02" | ind == "Pd_58"| ind == "Pd_59")

clones <- df_long |> filter(ind == "Pd_36" | ind == "Pd_37" | ind == "Pd_39" | ind == "Pd_45")

europes <- df_long |> filter(continent == "Europe")

europe_majority <- df_long |> filter(continent == "Europe") |> filter(admix > 0.90)

ggplot(pop11_2,aes(x=ind,y=admix,fill=country)) +
scale_fill_manual(values = cols) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid( ~ continent, scales = "free_x", space="free_x", switch = "x", labeller = as_labeller(continents_label)) +
labs(title = "Only Pd Samples: by Continent", x = "Individuals", y = "Admix")