library(ggplot2)
library(see)
library(dplyr)
library(ggh4x)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_12-08_n-amer-pd_pcangsd_longdf.csv")
df_continent <- df_long |> group_by(continent) |> arrange(.by_group = TRUE)

# og graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.5, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
labs(title = "North American Pd Samples PCAngsd Admixture", x = "Individuals", y = "Admix") 

## grouped by country graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_wrap( ~ country, strip.position = "bottom", scales = "free_x") +
labs(title = "North American Pd Samples by Country", x = "Individuals", y = "Admix") 

## grouped by state graph
df_canada = df_long |> dplyr::filter(country=="Canada")
df_usa = df_long |> dplyr::filter(country=="USA")

# canada by state
ggplot(df_canada,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid2(~ state, scales = "free_x", space= "free_x")

# usa by state
ggplot(df_usa,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_viridis_d() +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid2(~ state, scales = "free_x", space= "free_x")