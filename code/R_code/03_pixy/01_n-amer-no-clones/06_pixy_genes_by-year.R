library(dplyr)
library(readr)
library(ggplot2)
library(cowplot)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/01_n-amer-no-clones/02_pixy-output/03_genes/01_by-year")

fst_df <- read_tsv("n-amer-no-clones_by-year_fst.txt")
pi_df <- read_tsv("n-amer-no-clones_by-year_pi.txt")
dxy_df <- read_tsv("n-amer-no-clones_by-year_dxy.txt")
tajima_d_df <- read_tsv("n-amer-no-clones_by-year_tajima_d.txt")

gene_info <- read_tsv("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/06_pixy/pd_gene_info.txt")

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

#########################
## making the graphs
#########################



################# fst: 2008 compared to all other years
pop1_compar_df <- fst_dxy_df |> mutate(.before=pop1 , year_compar = as.character((abs((as.numeric(gsub("\\D+", "",(paste(pop1)))) + 2007) - (as.numeric(gsub("\\D+", "",(paste(pop2)))) + 2007)) + 1) + 2007)) |> filter(pop1=="pop1" | pop2 =="pop1")

year1_compar_plot <- ggplot(data=pop1_compar_df, aes(x=year_compar, y=avg_hudson_fst)) +
  geom_violin() +
  labs(title = "Fst for 2008 vs all other years, North America Samples", x = "Year Comparisons", y = "Average Fst")
year1_compar_plot


####################################################################################

######################
# making a new graph
######################

gene_df <- 

highest_fst_genes <- fst_df |> mutate(.before=pop1, chromosome_number = as.numeric(gsub(".1","",(gsub("NW_","",paste(chromosome))),fixed =TRUE))) |> arrange(chromosome_number, window_pos_1)


|> filter(avg_hudson_fst == 1) |> count(pop2)
# 52 genes
# all compared to pop9 (2016)

ggplot(highest_fst_genes, aes(x=chromosome, y=n)) +
  geom_point() +
  labs(title = "Average Fst > 1 Gene Count per Scaffold", x = "Genome Scaffolds", y = "Number of Genes with Fst > 1", color = "Year") +
  scale_color_manual(values = cols) +
  theme +
  theme(axis.title.x=element_blank(),axis.ticks.x = element_blank(),axis.text.x = element_blank())


