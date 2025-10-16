library(ggplot2)
library(see)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_10-16_pd_pcangsd_longdf")

ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_okabeito(
  palette = "full",
  reverse = FALSE,
  order = 1:6,
  aesthetics = "fill",
  ) +
geom_col(col=NA,inherit.aes = TRUE)