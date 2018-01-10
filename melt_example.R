setwd("/Users/malte.quast/Documents/R/")
library(reshape2)
library(MASS)
data <- read.csv(file = "melt.csv", header = TRUE, sep = ';', dec = ',')

??melt
data2 <- melt(data, c(1))
data2

dim(data)

fitdistr(data[c(2:14),2],'normal')
is.character(data[2,3])
?sample
