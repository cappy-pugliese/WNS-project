library(ggplot2)
library(see)
library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_12-07_only-pd_pcangsd_longdf.csv")
df_continent <- df_long |> group_by(continent) |> arrange(.by_group = TRUE)

# og graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.5, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE)

## grouped by continent graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_wrap( ~ continent, strip.position = "bottom", scales = "free_x")