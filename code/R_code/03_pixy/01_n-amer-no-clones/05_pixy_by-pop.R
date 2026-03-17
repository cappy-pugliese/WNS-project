library(dplyr)
library(readr)
library(ggplot2)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/02_larger_window/02_by-pops")

fst_df <- read_tsv("n-amer-no-clones_by-pops2_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-pops2_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-pops2_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-pops2_tajima_d.txt")

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
fst_dxy_df <- selected_fst_dxy[complete.cases(selected_fst_dxy[ , 6]),]

##########################
## part2 
##########################

pop1_2_summary <- fst_dxy_df |> filter(pop1 == "pop01" & pop2 == "pop02") |> group_by(chromosome) |> summarize(avg = mean(avg_hudson_fst))
pop1_2_summary$x <- 1:83

pop1_2 <- fst_dxy_df |> filter(pop1 == "pop01" & pop2 == "pop02") |> arrange(chromosome,window_pos_1)

pop1_2 <- pop1_2 |> mutate(.before=pop1, window_order = (paste(chromosome,window_pos_1, sep = "_"))) |> select(window_order, pop1, pop2, chromosome, avg_hudson_fst, avg_dxy)

pop1_2 <- pop1_2 |> 
  mutate(genome_group = factor(ceiling(row_number() / 968)))

############# across the genome plots
####### 2008 vs 2009
ggplot(data=pop1_2_summary, aes(x=x,y=avg)) +
  geom_point() +
  labs(title = "Fst for pop1 vs pop2", x = "genome scaffolds", y = "Average Fst") 

across_genome_1_2 <- ggplot(data=pop1_2, aes(x=genome_group, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for pop1 vs pop2", x = "Moving across the genome", y = "Average Fst")
across_genome_1_2

############# across the genome plots
####### 2008 vs 2016
pop7_1 <- fst_dxy_df |> filter(pop1 == "pop07" & pop2 == "pop01") |> arrange(chromosome,window_pos_1)
pop7_1 <- pop7_1 |> mutate(.before=pop1, window_order = (paste(chromosome,window_pos_1, sep = "_"))) |> select(window_order, pop1, pop2, chromosome, avg_hudson_fst, avg_dxy)
pop7_1 <- pop7_1 |> 
  mutate(genome_group = factor(ceiling(row_number() / 968)))

across_genome_7_1 <- ggplot(data=pop7_1, aes(x=genome_group, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for pop1 vs pop7", x = "Moving across the genome", y = "Average Fst")
across_genome_7_1



##############################
## left off here!
##############################

## might have to just make new graphs
## compare everything



################# fst: 2008 compared to all other years
pop1_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character((abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) + 2007) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) + 2007)) + 1) + 2007)) |> filter(pop1=="pop1" | pop2 =="pop1")

year1_compar_plot <- ggplot(data=pop1_compar_df, aes(x=year_compar, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for 2008 vs all other years, North America Samples", x = "Year Comparisons", y = "Average Fst")
year1_compar_plot

nrow(pop1_compar_df)
totaln_per_year <- pop1_compar_df |> group_by(year_compar) |> count() |> filter(year_compar!="2014")

########################################################
## Have Andrius check math, I probably did things wrong
########################################################
pop1_compar_df2 <- pop1_compar_df |> filter(avg_hudson_fst > 0) |> group_by(year_compar) |> count()
pop1_compar_df2$totaln <- totaln_per_year$n
pop1_compar_df2$weights <- c(6,7,5,11,9,5,2)
pop1_compar_df2 <- pop1_compar_df2 |> mutate(weights1=n/totaln,weights2 = weights/45, weighted_n = (n/totaln)/weights2)
pop1_compar_df2

year1_compar_plot_weighted <- ggplot(data=pop1_compar_df2, aes(x=year_compar, y=weighted_n)) +
  geom_point() +
  labs(title = "Fst for 2008 vs all other years, North America Samples, Weighted(?)", x = "Year Comparisons", y = "Count for Fst > 0")
year1_compar_plot_weighted

year1_compar_plot2 <- ggplot(data=pop1_compar_df2, aes(x=year_compar, y=(weights1*100))) +
  geom_point() +
  labs(title = "Fst for 2008 vs all other years, North America Samples", x = "Year Comparisons", y = "Count for Fst > 0")
year1_compar_plot2

################# fst: 2016 compared to all other years
pop9_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character(2017 - (abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) - 2016) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) - 2016)) + 1))) |> filter(pop1=="pop9" | pop2 =="pop9")

year9_compar_plot <- ggplot(data=pop9_compar_df, aes(x=year_compar, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for 2016 vs all other years, North America Samples", x = "Year Comparisons", y = "Average Fst")
year9_compar_plot

totaln_per_year <- pop9_compar_df |> group_by(year_compar) |> count() |> filter(year_compar!="2014")
pop9_compar_df2 <- pop9_compar_df |> filter(avg_hudson_fst > 0) |> group_by(year_compar) |> count()
pop9_compar_df2$totaln <- totaln_per_year$n
pop9_compar_df2$weights <- c(5,6,7,5,11,9,5)
pop9_compar_df2 <- pop9_compar_df2 |> mutate(weights1=n/totaln,weights2 = weights/45, weighted_n = (n/totaln)/weights2)
pop9_compar_df2

year9_compar_plot_weighted <- ggplot(data=pop9_compar_df2, aes(x=year_compar, y=weighted_n)) +
  geom_point() +
  labs(title = "Fst for 2016 vs all other years, North America Samples, Weighted(?)", x = "Year Comparisons", y = "Count for Fst > 0")
year9_compar_plot_weighted

year9_compar_plot2 <- ggplot(data=pop9_compar_df2, aes(x=year_compar, y=(weights1*100))) +
  geom_point() +
  labs(title = "Fst for 2016 vs all other years, North America Samples", x = "Year Comparisons", y = "Count for Fst > 0")
year9_compar_plot2