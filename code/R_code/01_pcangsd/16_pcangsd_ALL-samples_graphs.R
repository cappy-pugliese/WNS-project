library(ggplot2)
#library(see)
#library(colorblindr)
library(dplyr)

setwd("/Users/caprinapugliese/Documents/03_school/Uconn/2024-26_Grad_School/Dagilis-lab/WNS-project/data/04_pcangsd")
df_long <- read.csv("26_04-25_ALL-samples_pcangsd_longdf.csv")

cols <- c("#064061", "#56B4E9","#009E73","#FDF17B","#E69F00","#D55E00","#9C4907")

# og graph
plot1 <- ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_manual(values = rev(cols)) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.5, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
labs(title = "All samples, including outgroups", x = "Individuals", y = "Admix") 
plot1

## grouped by country graph
plot2 <- ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_manual(values = rev(cols)) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_wrap( ~ group, strip.position = "bottom", scales = "free_x") +
labs(title = "All samples, including outgroups", x = "Individuals Separated by group", y = "Admix") 
plot2
#cvd_grid(plot2)

## grouped by year
ggplot(df_long,aes(x=ind,y=admix,fill=Pop)) +
scale_fill_manual(values = rev(cols)) +
geom_col(col=NA,inherit.aes = TRUE) +
theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8), legend.key.size=unit(0.3, 'cm')) +
geom_col(col=NA,inherit.aes = TRUE) +
facet_grid( ~ year, scales = "free_x", space="free_x", switch = "x") +
labs(title = "North American Pd Samples by Year", x = "Individuals Separated by Year", y = "Admix") 


####################################
# results calculations stuff
####################################

pop04 <- df_long |> filter(Pop == "pop04") |> filter(ind != "Pd_02", ind != "Pd_58", ind != "Pd_59")