library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

df_long <- read.csv("25_12-10_n-amer-no-clones_pcangsd_longdf.csv")

pop_df <- df_long |> dplyr::filter(admix > 0.5 | ind == "Pd_52"|ind =="Pd_53"|ind =="Pd_73") |> filter(admix > 0.34) |> filter(!row_number() %in% 26)


#missing <- df_long |> dplyr::filter(ind == "Pd_52"|ind =="Pd_53"|ind =="Pd_73") |> dplyr::select(ind,Pop,admix) |> slice(1,8,21)
#missing = 52, 53, 73
#no longer missing

write.csv(pop_df,file="26_03-04_n-amer-no-clones_pops_df.csv",row.names=FALSE,quote=FALSE)

pixy_df <- pop_df |> dplyr::select(ind,Pop)
write.table(pixy_df, file="26_03-04_n-amer-no-clones_pops_df.tsv", quote=FALSE, sep='\t', col.names = FALSE,row.names=FALSE)