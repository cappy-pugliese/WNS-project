library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_10-16_pd_pcangsd_longdf.csv")

pop_df <- df_long |> dplyr::filter(admix > 0.5)

write.csv(pop_df,file="25_10-23_pcangsd_pops_df.csv",row.names=FALSE,quote=FALSE)

dsuite_df <- pop_df |> dplyr::select(ind,Pop)
write.table(dsuite_df, file="25_10-23_dsuite_df.tsv", quote=FALSE, sep='\t', col.names = FALSE,row.names=FALSE)