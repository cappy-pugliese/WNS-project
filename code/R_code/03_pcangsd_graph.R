library(ggplot2)
library(see)
library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_10-16_pd_pcangsd_longdf.csv")
df_continent <- df_long |> group_by(continent) |> arrange(.by_group = TRUE)

# og graph
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:6,
  aesthetics = "fill",
  ) +
geom_col(col=NA,inherit.aes = TRUE)

# graph looking at continent population admixture
ggplot(df_continent,aes(x=continent,y=admix,fill=Pop,group=Pop)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:6,
  aesthetics = "fill",
  ) +
geom_col(col=NA,inherit.aes = TRUE)

# populations by continent
ggplot(df_continent,aes(x=Pop,y=admix,fill=continent,group=continent)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:3,
  aesthetics = "fill",
  ) +
geom_col(col=NA,inherit.aes = TRUE)

# by country
ggplot(df_long,aes(x=country,y=admix,fill=Pop,group=Pop)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:6,
  aesthetics = "fill",
  ) +
scale_x_discrete(limits = c("USA", "Canada", "Czech Republic","Ukraine","Hungary","France","Germany","Switzerland","Mongolia")) +
geom_col(col=NA,inherit.aes = TRUE)

# by state- not that great
ggplot(df_long,aes(x=state,y=admix,fill=Pop,group=Pop)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:6,
  aesthetics = "fill",
  ) +
theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
geom_col(col=NA,inherit.aes = TRUE)