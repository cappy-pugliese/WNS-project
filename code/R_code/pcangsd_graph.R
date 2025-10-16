#install.packages("reticulate")
library("reticulate")
# to help read .npy file
np <- import("numpy")
# good for combining python with R
library(readr)
library(tidyverse)
library(ggplot2)
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

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/03_vcfs")
vcf = read.vcfR("pd.vcf.gz")
GT = extract.gt(vcf,element="GT",as.numeric=TRUE)

GT <- as.data.frame(GT)
rownames(admix) = colnames(GT)
admix$ind = colnames(GT)

#Pivot to long format
df_long = pivot_longer(admix,1:k,names_to="Pop",values_to="admix")

ggplot(df_long,aes(x=ind,y=admix,fill=Pop))+geom_col(col=NA)