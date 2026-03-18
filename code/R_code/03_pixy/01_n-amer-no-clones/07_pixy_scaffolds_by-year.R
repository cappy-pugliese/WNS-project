library(dplyr)
library(readr)
library(ggplot2)
library(cowplot)
library(patchwork)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/04_scaffolds/01_by-year/")

fst_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_tajima_d.txt")

### variables
theme <- theme_cowplot()

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

###########################################################################

###### fixing pi NAs ######
pi_df
tajima_d_df

merged_pi_tajima_d <- left_join(pi_df, tajima_d_df)

###########################################################################

#########################
## making the graphs
#########################
pop1_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character((abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) + 2007) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) + 2007)) + 1) + 2007)) |> filter(pop1=="pop1" | pop2 =="pop1") |> group_by(chromosome)
############# across the genome plots: fst and dxy
####### 2008 vs 2009 fst
#pop1_2_acrossgenome <- fst_dxy_df |> filter(pop1 == "pop1" | pop2 == "pop1") |> group_by(chromosome)
#pop1_2_acrossgenome$x <- 1:83
plot1_2_acrossgenome_fst <- ggplot(data=pop1_compar_df, aes(x=chromosome,y=avg_hudson_fst, color=year_compar)) +
  geom_point() +
  labs(title = "Fst of Each Scaffold Per Year Compared to 2008", x = "Genome Scaffolds", y = "Average Fst", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot1_2_acrossgenome_fst

####### 2008 vs 2009 dxy
plot1_2_acrossgenome_dxy <- ggplot(data=pop1_2_acrossgenome, aes(x=x,y=avg_dxy)) +
  geom_point() +
  labs(title = "Dxy for 2008 vs 2009", x = "Genome Scaffolds", y = "Dxy") +
  theme

plot1_2_acrossgenome_fst / plot1_2_acrossgenome_dxy

####### 2008 vs 2016 fst
pop1_9_acrossgenome <- fst_dxy_df |> filter(pop1 == "pop9" & pop2 == "pop1") |> group_by(chromosome)
pop1_9_acrossgenome$x <- 1:83
plot1_9_acrossgenome_fst <- ggplot(data=pop1_9_acrossgenome, aes(x=x,y=avg_hudson_fst)) +
  geom_point() +
  labs(title = "Fst for 2008 vs 2016", x = "genome scaffolds", y = "Average Fst") +
  theme +
  theme(axis.title.x=element_blank(),axis.text.x = element_blank())

####### 2008 vs 2016 dxy
plot1_9_acrossgenome_dxy <- ggplot(data=pop1_9_acrossgenome, aes(x=x,y=avg_dxy)) +
  geom_point() +
  labs(title = "Dxy for 2008 vs 2016", x = "Genome Scaffolds", y = "Dxy") +
  theme

plot1_9_acrossgenome_fst / plot1_9_acrossgenome_dxy

############# across the genome plots: pi and tajima's d
years <- c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016)
cols <- c("#0072B2", "#56B4E9", "#B4E1FB", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907","#F5A9D3")

plot_acrossgenome_pi <- ggplot(data=merged_pi_tajima_d, aes(x=chromosome, y=avg_pi, color=pop)) +
  geom_point() +
  labs(title = "Average Pi for Each Genome Scaffold Per Year", x = "Genome Scaffolds", y = "Pi", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot_acrossgenome_pi


plot_acrossgenome_tajimad <- ggplot(data=merged_pi_tajima_d, aes(x=chromosome, y=tajima_d, color=pop)) +
  geom_point() +
  labs(title = "Tajima's D for Each Genome Scaffold Per Year", x = "Genome Scaffolds", y = "Tajima's D", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot_acrossgenome_tajimad


fst_dxy_df <- fst_dxy_df |> mutate(.after=pop2 ,pop_compars = paste(pop1,pop2, sep = "_"))



plot_acrossgenome_fst <- ggplot(data=fst_dxy_df, aes(x=chromosome, y=avg_hudson_fst, color=pop)) +
  geom_point() +
  labs(title = "Tajima's D for Each Genome Scaffold Per Year", x = "Genome Scaffolds", y = "Tajima's D", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot_acrossgenome_tajimad