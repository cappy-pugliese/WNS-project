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

admix <- np$load(file = "pcangsd_n-amer-pd.admix.11.Q.npy",allow_pickle=FALSE)
k <- 11
admix= as.data.frame(admix)
#head(admix)

########## making the graph ##########
pops <- c()
for (n in 1:k) {
    pops <- c(pops, paste0("pop", sprintf("%02d", n)))
}
colnames(admix) <- pops


indivs <- read.csv("n-amer_pd_ids.txt")
pd_locations <- read.csv("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/01_pd-samples/25_12-07_n-amer-pd_locations.csv")


rownames(admix) = indivs$individuals
admix$ind = indivs$individuals
admix$continent = pd_locations$continent
admix$country = pd_locations$country
admix$state = pd_locations$state


#Pivot to long format
df_long = pivot_longer(admix,1:k,names_to="Pop",values_to="admix")

write.csv(df_long,file="25_12-09_n-amer-pd_pcangsd_longdf.csv",row.names=FALSE,quote=FALSE)
