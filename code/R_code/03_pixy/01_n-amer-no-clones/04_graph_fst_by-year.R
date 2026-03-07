library(ggplot2)
library(dplyr)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/02_larger_window/01_by-year")

fst_dxy_df <- read.csv("26_03-06_fst_dxy_no_nas_10000.csv")

pop1_2_summary <- fst_dxy_df |> filter(pop1 == "pop1" & pop2 == "pop2") |> group_by(chromosome) |> summarize(avg = mean(avg_hudson_fst))
pop1_2_summary$x <- 1:83

pop1_2 <- fst_dxy_df |> filter(pop1 == "pop1" & pop2 == "pop2") |> arrange(chromosome,window_pos_1)

pop1_2 <- pop1_2 |> mutate(.before=pop1, window_order = (paste(chromosome,window_pos_1, sep = "_"))) |> select(window_order, pop1, pop2, chromosome, avg_hudson_fst, avg_dxy)

pop1_2 <- pop1_2 |> 
  mutate(genome_group = factor(ceiling(row_number() / 968)))


ggplot(data=pop1_2_summary, aes(x=x,y=avg)) +
  geom_point() +
  labs(title = "Fst for Year1 vs Year2", x = "genome scaffolds", y = "Average Fst") 

violin_plot <- ggplot(data=pop1_2, aes(x=genome_group, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for Year1 vs Year2", x = "Moving across the genome", y = "Average Fst")
#ggplot(fst_dxy_df, aes(x=window_pos_1, y=)

pop1_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character((abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) + 2007) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) + 2007)) + 1) + 2007)) |> filter(pop1=="pop1" | pop2 =="pop1")

year1_compar_plot <- ggplot(data=pop1_compar_df, aes(x=year_compar, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for 2008 vs all other years, North America Samples", x = "Year Comparisons", y = "Average Fst")
year1_compar_plot
