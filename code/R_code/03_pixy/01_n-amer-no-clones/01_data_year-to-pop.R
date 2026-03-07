library(dplyr)
library(readr)
setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/01_pop-data")
df <- read.csv("26_03-02_n-amer-no-clones_pop-by-year.csv")

df_pop <- df |> mutate(pops = paste0("pop", dense_rank(year)))

write_tsv(df_pop,file="26_03-02_n-amer-no-clones_pop-by-year.tsv")