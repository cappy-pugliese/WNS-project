R_code_path <- "/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/code/R_code/02_algatr/"
source(paste0(R_code_path, "12_algatr_src.R"))

setwd("/Users/caprinapugliese/Documents/School/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd/04_n-amer-no-washington")

#FeCu_centered_scaled <- scale(FeCu_centered, center = FALSE, scale = TRUE)

## how genetically far apart the individuals are: euc_dists
## how geographically far apart the individuals are: geo_dist


## pcangsd tutorial
info <- read.csv("26_02-23_n-amer-no-washington_pca-info.csv")
cov <- as.matrix(read.table("pcangsd_n-amer-no-washington.cov"))
e <- eigen(cov)

pdf("PCAngsd1.pdf")
plot(e$vectors[,1:2],col=pop[,1],xlab="PC1",ylab="PC2", main="individual allele frequency")
legend("top",fill=1:5,levels(pop[,1]))
dev.off()

plot(e$vectors[,1:2],xlab="PC1",ylab="PC2", main="individual allele frequency")