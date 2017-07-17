rm(list = ls())

library(R.matlab)
library(extrafont)

my_data <- readMat("iEEG_pBands.mat")

a <- data.frame(my_data$bMat)

colnames(a) <- c("Width*","Height*",expression(delta),expression(theta),
                 expression(alpha), expression(beta), expression(gamma))

plotScMatrix <- dget("plotScMatrix.R")

plotScMatrix(a, histogram=TRUE)
