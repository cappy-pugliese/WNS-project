library(dplyr)
library(readr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/02_larger_window/01_by-year")

fst_df <- read_tsv("n-amer-no-clones_by-year2_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-year2_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-year2_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-year2_tajima_d.txt")

###### fixing fst NAs ######
dxy_df <- dxy_df |> mutate(.before=pop1 ,row_order = as.numeric(gsub("\\D+", "",(paste(chromosome,window_pos_1,pop1,pop2, sep = "_"))))) |> arrange(row_order)

fst_df <- fst_df |> mutate(.before=pop1 , row_order = as.numeric(gsub("\\D+", "",(paste(chromosome,window_pos_1,pop1,pop2, sep = "_"))))) |> arrange(row_order)

dxy_df <- dxy_df |> select(row_order,avg_dxy,no_sites,count_diffs,count_comparisons,count_missing)

merged_fst_dxy <- left_join(fst_df, dxy_df, by = "row_order")

selected_fst_dxy <- merged_fst_dxy |> select(row_order, pop1, pop2, chromosome, window_pos_1, avg_hudson_fst, avg_dxy)

# conditional statement: sets fst NAs to zero if dxy is also zero
selected_fst_dxy$avg_hudson_fst[is.na(selected_fst_dxy$avg_hudson_fst) & selected_fst_dxy$avg_dxy == 0] <- 0

#selected_fst_dxy |> summarise(across(avg_hudson_fst, ~ sum(is.na(.))))
#merged_fst_dxy |> summarise(across(avg_hudson_fst, ~ sum(is.na(.))))
# fixed 481812 NAs, still have 19339 NAs
# got rid of 96.1 % of NAs

## removes the rest of the rows with NAs
no_nas_fst_dxy <- selected_fst_dxy[complete.cases(selected_fst_dxy[ , 6]),]

write.csv(no_nas_fst_dxy,file="26_03-06_fst_dxy_no_nas_10000.csv",row.names=FALSE,quote=FALSE)


avg_the_avg <- no_nas_fst_dxy |> select(pop1,pop2,chromosome,window_pos_1,avg_hudson_fst,avg_dxy) |> mutate(.before=chromosome , group = as.numeric(gsub("\\D+", "",(paste(chromosome,pop1,pop2, sep = "_"))))) 

avg_the_avg |> filter(pop1 == "pop1" & pop2 == "pop2") |> group_by(chromosome) |> summarize(avg = mean(avg_hudson_fst))


nrow(avg_the_avg)
nrow(avg_the_avg |> filter(pop1 == "pop1" & pop2 == "pop2"))
length(unique(avg_the_avg$chromosome))