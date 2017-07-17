rm(list = ls())

library(R.matlab)

my_data <- readMat("fractals.mat")

a <- data.frame(my_data$fractalsMat)

colnames(a) <- c("DFA*","DFA","Hig*","Hig","St. Dev.","Mean")


plotScMatrix <- dget("plotScMatrix.R")

plotScMatrix(a, histogram=TRUE)
