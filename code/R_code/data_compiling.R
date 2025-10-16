library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples")

pd_samples <- read.csv("25_10-16_pd_samples-edited.csv")
paper_samples <- read.csv("strain_list.csv")
# setdiff(paper_loc_data$sra,sm_loc_data$sra)
missing_data <- dplyr::filter(paper_samples, sra != "SRR3545530")

location_data <- pd_samples |> dplyr::select(internal_line_id,sra,collection_date,continent,location,lat,long)

sm_loc_data <- location_data |> dplyr::select(sra,collection_date,continent,internal_line_id)
paper_loc_data <- missing_data |> dplyr::select(sra,year,continent,state)

merged <- full_join(sm_loc_data,paper_loc_data)

