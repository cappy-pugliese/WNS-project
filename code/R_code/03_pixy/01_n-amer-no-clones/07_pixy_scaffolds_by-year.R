library(dplyr)
library(readr)
library(ggplot2)
library(cowplot)
library(patchwork)

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/04_scaffolds/01_by-year/")

fst_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-year_scaffolds_tajima_d.txt")

### variables
theme <- theme_cowplot()
cols <- c("#064061","#0072B2","#56B4E9", "#B4E1FB", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907")

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

############# across the genome plots: fst and dxy
####### 2008 vs all
pop1_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character((abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) + 2007) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) + 2007)) + 1) + 2007)) |> filter(pop1=="pop1" | pop2 =="pop1") |> group_by(chromosome)
### fst
cols2 <- c("#0072B2","#56B4E9", "#B4E1FB", "#009E73","#DACE1E","#E69F00","#D55E00","#9C4907")
plot2008_acrossgenome_fst <- ggplot(data=pop1_compar_df, aes(x=chromosome,y=avg_hudson_fst, color=year_compar)) +
  geom_point() +
  labs(title = "Fst of Each Scaffold Per Year Compared to 2008", x = "Genome Scaffolds", y = "Average Fst", color = "Year") +
  scale_color_manual(values = cols2) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())
### dxy
plot2008_acrossgenome_dxy <- ggplot(data=pop1_compar_df, aes(x=chromosome,y=avg_dxy, color=year_compar)) +
  geom_point() +
  labs(title = "Dxy of Each Scaffold Per Year Compared to 2008", x = "Genome Scaffolds", y = "Average Dxy", color = "Year") +
  scale_color_manual(values = cols2) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot2008_acrossgenome_fst / plot2008_acrossgenome_dxy

####### 2016 vs all
pop9_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character(2017 - (abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) - 2016) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) - 2016)) + 1))) |> filter(pop1=="pop9" | pop2 =="pop9")

### fst
plot2016_acrossgenome_fst <- ggplot(data=pop9_compar_df, aes(x=chromosome,y=avg_hudson_fst, color=year_compar)) +
  geom_point() +
  labs(title = "Fst of Each Scaffold Per Year Compared to 2016", x = "Genome Scaffolds", y = "Average Fst", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())
### dxy
plot2016_acrossgenome_dxy <- ggplot(data=pop9_compar_df, aes(x=chromosome,y=avg_dxy, color=year_compar)) +
  geom_point() +
  labs(title = "Dxy of Each Scaffold Per Year Compared to 2016", x = "Genome Scaffolds", y = "Average Dxy", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot2016_acrossgenome_fst / plot2016_acrossgenome_dxy

###################### cut fst and dxy graphs
cut_pop1_compar_df <- pop1_compar_df |> mutate(.before=chromosome, scaffold_num=as.numeric(gsub("NW_|\\.1", "",(paste(chromosome))))) |> filter(scaffold_num<20167560)

plot2016_acrossgenome_fst <- ggplot(data=cut_pop1_compar_df, aes(x=chromosome,y=avg_hudson_fst, color=year_compar)) +
  geom_line(aes(color=year_compar, group=year_compar),size = 1.2) +
  labs(title = "Fst of Each Scaffold Per Year Compared to 2016", x = "Genome Scaffolds", y = "Average Fst", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())
### dxy
plot2016_acrossgenome_dxy <- ggplot(data=cut_pop1_compar_df, aes(x=chromosome,y=avg_dxy, color=year_compar)) +
  geom_line(aes(color=year_compar, group=year_compar),size = 1.2) +
  labs(title = "Dxy of Each Scaffold Per Year Compared to 2016", x = "Largest Genome Scaffolds", y = "Average Dxy", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())
plot2016_acrossgenome_fst / plot2016_acrossgenome_dxy

################### comparing years

plot_by_year_fst <- ggplot(data=cut_pop1_compar_df, aes(x=year_compar, y=avg_hudson_fst)) +
  geom_boxplot(aes(fill=year_compar)) +
  labs(title = "Average Fst Across the Genome Per Year", x = "Year", y = "Average Fst", fill = "Year") +
  scale_fill_manual(values = cols2) +
  theme +
  theme(legend.position="none")
plot_by_year_fst

plot_by_year_dxy <- ggplot(data=cut_pop1_compar_df, aes(x=year_compar, y=avg_dxy)) +
  geom_boxplot(aes(fill=year_compar)) +
  labs(title = "Average Dxy Across the Genonme Per Year", x = "Year", y = "Average Dxy", fill = "Year") +
  scale_fill_manual(values = cols2) +
  theme +
  theme(legend.position="none")
plot_by_year_dxy

plot_by_year_fst / plot_by_year_dxy

############# across the genome plots: pi and tajima's d
years <- c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016)

plot_acrossgenome_pi <- ggplot(data=merged_pi_tajima_d, aes(x=chromosome, y=avg_pi, color=pop)) +
  geom_line(aes(color=pop, group=pop),size = 1.2) +
  labs(title = "Average Pi for Each Genome Scaffold Per Year", x = "Genome Scaffolds", y = "Average Pi", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())

plot_acrossgenome_tajimad <- ggplot(data=merged_pi_tajima_d, aes(x=chromosome, y=tajima_d, color=pop)) +
  geom_line(aes(color=pop, group=pop),size = 1.2) +
  labs(title = "Tajima's D for Each Genome Scaffold Per Year", x = "Genome Scaffolds", y = "Tajima's D", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())

plot_acrossgenome_pi / plot_acrossgenome_tajimad


################# cut across the genome pi & tajima's d
cut_pi_tajima_d <-merged_pi_tajima_d |> select(pop,chromosome,avg_pi,tajima_d) |>  mutate(.before=chromosome, scaffold_num=as.numeric(gsub("NW_|\\.1", "",(paste(chromosome)))))

cut_pi_tajima_d <- cut_pi_tajima_d |> group_by(scaffold_num) |> arrange(.by_group=TRUE) |> filter(scaffold_num<20167548)

plot_acrossgenome_pi <- ggplot(data=cut_pi_tajima_d, aes(x=chromosome, y=avg_pi, color=pop)) +
  geom_line(aes(color=pop, group=pop),size = 1.2) +
  labs(title = "Average Pi for Each Genome Scaffold Per Year", x = "Largest Genome Scaffolds", y = "Average Pi", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())

plot_acrossgenome_tajimad <- ggplot(data=cut_pi_tajima_d, aes(x=chromosome, y=tajima_d, color=pop)) +
  geom_line(aes(color=pop, group=pop),size = 1.2) +
  labs(title = "Tajima's D for Each Genome Scaffold Per Year", x = "Largest Genome Scaffolds", y = "Tajima's D", color = "Year") +
  scale_color_manual(labels = years, values = cols) +
  theme +
  theme(axis.ticks.x = element_blank(),axis.text.x = element_blank())

plot_acrossgenome_pi / plot_acrossgenome_tajimad

######## comparing years pi & tajima's d
cut_pi_tajima_d <- cut_pi_tajima_d |> mutate(.before=pop, year=as.character(2007+(as.numeric(gsub("\\D+", "",paste(pop))))))

cols3 <- c("#064061","#0072B2","#56B4E9", "#B4E1FB", "#009E73","#DACE1E","#D55E00","#9C4907")

plot_by_year_pi <- ggplot(data=cut_pi_tajima_d, aes(x=year, y=avg_pi)) +
  geom_boxplot(aes(fill=year)) +
  labs(title = "Average Pi Across the Genome Per Year", x = "Year", y = "Average Pi", fill = "Year") +
  scale_fill_manual(values = cols3) +
  theme +
  theme(legend.position="none")
plot_by_year_pi

plot_by_year_tajima_d <- ggplot(data=cut_pi_tajima_d, aes(x=year, y=tajima_d)) +
  geom_boxplot(aes(fill=year)) +
  labs(title = "Average Tajima's D Across the Genonme Per Year", x = "Year", y = "Average Tajima's D", fill = "Year") +
  scale_fill_manual(values = cols3) +
  theme +
  theme(legend.position="none")
plot_by_year_tajima_d

plot_by_year_pi / plot_by_year_tajima_d