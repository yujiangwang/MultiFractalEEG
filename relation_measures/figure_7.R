rm(list = ls())

library(R.matlab)

my_data <- readMat("bMat.mat")

a <- data.frame(my_data$bMat)

colnames(a) <- c("Width","Height","Width*","Height*","Mean","St. Dev.",
                 "LL", "DFA*", "DFA")

plotScMatrix <- dget("plotScMatrix.R")

plotScMatrix(a, histogram=TRUE)