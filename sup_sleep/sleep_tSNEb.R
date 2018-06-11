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
library(Rtsne)
library(ggplot2)

my_data <- read.csv("sleep_ST7011J.csv",header=FALSE)

my_data <- rbind(my_data,read.csv("sleep_ST7022J.csv",header=FALSE))
my_data <- rbind(my_data,read.csv("sleep_ST7041J.csv",header=FALSE))
my_data <- rbind(my_data,read.csv("sleep_ST7052J.csv",header=FALSE))
my_data <- rbind(my_data,read.csv("sleep_ST7061J.csv",header=FALSE))

names(my_data) <- c("phase","width_cz","deltaF_cz","deltaPR_cz","width_oz",
                    "deltaF_oz","deltaPR_oz")

my_data[my_data$phase == "-1",]$phase = "Wake"
my_data[my_data$phase == "-2",]$phase = "REM"
my_data[my_data$phase == "-3",]$phase = "S1"
my_data[my_data$phase == "-4",]$phase = "S2"
my_data[my_data$phase == "-5",]$phase = "S3"
my_data[my_data$phase == "-6",]$phase = "S4"

my_data <- data.frame(my_data)

reduceDim <- Rtsne(my_data[,2:7],perplexity = 40,max_iter = 1000)
tSNE <- data.frame(reduceDim$Y,my_data$phase)
names(tSNE) <- c("tSNE1","tSNE2","Phase")

ggplot(tSNE, aes(x=X1,y=X2,color=my_data.phase)) + geom_point(shape=19) + 
  theme_bw(base_size = 18) +
  scale_colour_brewer(palette = "Spectral") +
  labs(x="t-SNE1",y="t-SNE2",color = "Sleep stages")

ggsave("tSNE_all.eps")
ggsave("tSNE_all.png")
