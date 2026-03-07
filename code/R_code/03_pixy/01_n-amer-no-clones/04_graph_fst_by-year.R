library(ggplot2)
library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/02_larger_window/01_by-year")

fst_dxy_df <- read.csv("26_03-06_fst_dxy_no_nas_10000.csv")

pop1_2_summary <- fst_dxy_df |> filter(pop1 == "pop1" & pop2 == "pop2") |> group_by(chromosome) |> summarize(avg = mean(avg_hudson_fst))

pop1_2 <- fst_dxy_df |> filter(pop1 == "pop1" & pop2 == "pop2") |> arrange(chromosome,window_pos_1)

pop1_2_summary$x <- 1:83



pop1_2 <- pop1_2 |> mutate(.before=pop1 , window_order = (paste(chromosome,window_pos_1, sep = "_"))) |> select(window_order, pop1, pop2, chromosome, avg_hudson_fst, avg_dxy)

test_df <- pop1_2 |> 
  mutate(group_1000 = (row_number() - 1) / 968 + 1)

test_df <- df %>%
  mutate(group_1000 = (row_number() - 1) %/% 1000 + 1)

ggplot(data=pop1_2_summary, aes(x=x,y=avg)) +
  geom_point() +
  labs(title = "Fst for Year1 vs Year2", x = "genome scaffolds", y = "Average Fst") 

ggplot(data=pop1_2, aes(x=chromosome, y=avg_hudson_fst)) +
  geom_violin() +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.1)
#ggplot(fst_dxy_df, aes(x=window_pos_1, y=)