library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples")

df <- read.csv("26_03-10_sraruns.csv")
df_proj <- read.csv("26_03-10_only-pd_sra.csv")
df_all_pd <- read.csv("26_02-25_only-pd_info.csv")
df_northamer <- read.csv("25_12-10_n-amer-no-clones_locations.csv")

df_match <- data.frame(match(df_proj$sra, df$Run_WGS_fasta))
sapply(df_match, function(x) sum(is.na(x)))
#26-30 don't match

df_match <- data.frame(match(df$og_sra, df$Run_WGS))
sapply(df_match, function(x) (sum(!is.na(x)) - sum(is.na(x))))


(df_all_pd |> filter(continent == "Europe"))

nrow(df_all_pd |> filter(continent == "Europe"))
nrow(df_all_pd |> filter(continent == "Asia"))
nrow(df_all_pd |> filter(continent == "N_America"))
