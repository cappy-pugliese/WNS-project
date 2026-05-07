library(dplyr)

################### majority populations
setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("25_12-10_n-amer-no-clones_pcangsd_longdf.csv")

pop_df_missing <- df_long |> dplyr::filter(admix > 0.3) |> filter(admix < 0.5) |> filter(ind == "Pd_52" | ind == "Pd_53" | ind =="Pd_73")
# missing: 52, 53, 73
# already have: 54, 56, 65, 68, 78, 79
pop_df50 <- df_long |> dplyr::filter(admix > 0.5)

pop_df <- df_long |> filter(admix > 0.5 | ind == "Pd_52" | ind == "Pd_53" | ind =="Pd_73") |> filter(admix > 0.3) |> filter(ind != "Pd_52" | admix > 0.45) |> filter (ind != "Pd_53" | admix > 0.34) |> filter(ind != "Pd_73" | admix > 0.38) |> select(ind, year, Pop, admix)

pop_df <- pop_df |> mutate(.before=Pop, pop_num = gsub("0","",(gsub("\\D+", "",Pop)))) |> select(ind, year, pop_num, admix)



write.csv(pop_df,file="/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/05_algatr/26_05-07_no-wash_major-pop-and-time.csv",row.names=FALSE,quote=FALSE)