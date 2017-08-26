rm(list = ls())

library(R.matlab)
library(ggplot2)
library(ggjoy)

my_data <- readMat("iEEG_pBands.mat")

a <- data.frame(my_data$bMat)


ggplot(a, aes(y = cut)) +
  geom_joy(scale = 4) + theme_joy() +
  scale_y_discrete(expand = c(0.01, 0)) +   # will generally have to set the `expand` option
  scale_x_continuous(expand = c(0, 0))      # for both axes to remove unneeded padding