#install.packages("reticulate")
library("reticulate")
# to help read .npy file
np <- import("numpy")
# good for combining python with R
library(readr)
library(tidyverse)
library(ggplot2)
library(see)
library(vcfR)

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")

admix <- np$load(file = "pcangsd_pd.admix.6.Q.npy",allow_pickle=FALSE)
k <- 6
admix= as.data.frame(admix)
#head(admix)

########## making the graph ##########
pops <- c()
for (n in 1:k) {
    pops <- c(pops, paste0("pop", n))
}
colnames(admix) <- pops


indivs <- read.csv("ind_ids.txt")


rownames(admix) = indivs$individuals
admix$ind = indivs$individuals


#Pivot to long format
df_long = pivot_longer(admix,1:k,names_to="Pop",values_to="admix")

write.csv(df_long,file="25_10-16_pd_pcangsd_longdf",row.names=FALSE,quote=FALSE)
