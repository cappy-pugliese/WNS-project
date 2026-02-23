library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples")

pd_samples <- read.csv("25_10-16_pd_samples-edited.csv")

pd_locations <- pd_samples |> dplyr::select(internal_line_id, continent, country, state, year)

write.csv(pd_locations,file="25_10-16_pd_locations.csv",row.names=FALSE,quote=FALSE)