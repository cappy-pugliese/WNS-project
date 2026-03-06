library(dplyr)
library(readr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/01_by-year")

fst_df <- read_tsv("n-amer-no-clones_by-year_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-year_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-year_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-year_tajima_d.txt")


dxy_df2 <- dxy_df |> mutate(.before=pop1 ,row_order = as.numeric(gsub("\\D+", "",(paste(chromosome,window_pos_1,pop1,pop2, sep = "_"))))) |> arrange(row_order)

fst_df2 <- fst_df |> mutate(.before=pop1 , row_order = as.numeric(gsub("\\D+", "",(paste(chromosome,window_pos_1,pop1,pop2, sep = "_"))))) |> arrange(row_order)

## brain thoughts on what to do
### - use dplyr to merge pop1 and pop2 columns into one
### - maybe can do something like turn pop8 and pop3 into 83, that way it is easier to sort by order?
### - first order by window_pos_1 and then by pop_compar number?

dxy_df3 <- dxy_df2 |> select(row_order,avg_dxy,no_sites,count_diffs,count_comparisons,count_missing)

merged_fst_dxy <- left_join(fst_df2, dxy_df3, by = "row_order")

selected_fst_dxy <- merged_fst_dxy |> select(row_order, pop1, pop2, chromosome, window_pos_1, avg_hudson_fst, avg_dxy)

# conditional statement: sets fst NAs to zero if dxy is also zero
selected_fst_dxy$avg_hudson_fst[is.na(selected_fst_dxy$avg_hudson_fst) & selected_fst_dxy$avg_dxy == 0] <- 0

selected_fst_dxy |> summarise(across(avg_hudson_fst, ~ sum(is.na(.))))
merged_fst_dxy |> summarise(across(avg_hudson_fst, ~ sum(is.na(.))))