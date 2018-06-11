# LICENSE
# 
# This software is licensed under an MIT License.
# 
# Copyright (c) 2018 Lucas G S França, Yujiang Wang.
# 
# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the "Software"), 
# to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the 
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
# 
# Authors: Lucas França(1), Yujiang Wang(1,2,3)
# 
# 1 Department of Clinical and Experimental Epilepsy, UCL Institute of Neurology,
# University College London, London, United Kingdom
# 
# 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research group,
# School of Computing Science, Newcastle University, Newcastle upon Tyne,
# United Kingdom
# 
# 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
# United Kingdom
# 
# email address: lucas.franca.14@ucl.ac.uk, Yujiang.Wang@newcastle.ac.uk
# Website: https://lucasfr.github.io/, http://xaphire.de/

rm(list = ls())

library(R.matlab)
library(reshape2)
library(RColorBrewer)
library(ggplot2)

mat <- readMat("MI.mat")

varNames <- c("1Width","2deltaF","3Width-dg","4deltaF-dg","5Mean","6St. Dev.","7LL")

MI <- data.frame(mat$MI)
MI <- signif(MI, digits = 2)
names(MI) <- t(varNames)


# Get lower triangle of the correlation matrix
get_lower_tri<-function(mat){
  mat[upper.tri(mat)] <- NA
  return(mat)
}
# Get upper triangle of the correlation matrix
get_upper_tri <- function(mat){
  mat[lower.tri(mat)]<- NA
  return(mat)
}


lower_tri <- get_lower_tri(MI)
lower_tri <- cbind(varNames,lower_tri)
melted_mat <- melt(lower_tri, na.rm = TRUE)


PaletteFun <- colorRampPalette(rev(brewer.pal(n = 5, "Purples")))
paletteSize <- 64
matPalette <- PaletteFun(paletteSize)

# Heatmap

ggplot(data = melted_mat, aes(varNames, variable, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = matPalette[paletteSize], high = matPalette[1], 
                       mid = matPalette[paletteSize/2], 
                       midpoint = 0, limit = c(min(melted_mat$value),
                                               max(melted_mat$value)), space = "Lab", 
                       name="Mutual Information") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed() + 
  geom_text(aes(varNames, variable, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    panel.background = element_blank(),
    legend.direction = "horizontal") +
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))
