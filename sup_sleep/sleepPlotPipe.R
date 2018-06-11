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
library(ggplot2)

violinPlotSleep <- dget("violinPlotSleep.R")

my_data <- readMat("sleep_ST7011J.mat")
data <- data.frame(my_data$bMat)
nm <- "ST7011J"


colnames(data) <- c("phase","width_cz","deltaF_cz","deltaPR_cz","width_oz",
                    "deltaF_oz","deltaPR_oz")

if (length(data[data$phase == "-1",1]) > 0){
  data[data$phase == "-1",]$phase = "Wake"
}

if (length(data[data$phase == "-2",1]) > 0){
  data[data$phase == "-2",]$phase = "REM"
}

if (length(data[data$phase == "-3",1]) > 0){
  data[data$phase == "-3",]$phase = "S1"
}

if (length(data[data$phase == "-4",1]) > 0){
  data[data$phase == "-4",]$phase = "S2"
}

if (length(data[data$phase == "-5",1]) > 0){
  data[data$phase == "-5",]$phase = "S3"
}

if (length(data[data$phase == "-6",1]) > 0){
  data[data$phase == "-6",]$phase = "S4"
}


ggplot(data, aes(x=phase, y=width_cz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste(Delta,alpha))) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),
        text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")

ggsave(filename = "vlinPlot_sleep_cz_width_ST7011J.pdf", width = 7, height = 7,
       units = "in")


ggplot(data, aes(x=phase, y=deltaF_cz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste(Delta,f)))+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")

ggsave(filename = "vlinPlot_sleep_cz_deltaF_ST7011J.pdf", width = 7, height = 7,
       units = "in")


ggplot(data, aes(x=phase, y=deltaPR_cz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste("P(",delta,")"))) +
    theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")

ggsave(filename = "vlinPlot_sleep_cz_deltaPR_ST7011J.pdf", width = 7, height = 7,
       units = "in")

ggplot(data, aes(x=phase, y=width_oz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste(Delta,alpha))) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")

ggsave(filename = "vlinPlot_sleep_oz_width_ST7011J.pdf", width = 7, height = 7,
       units = "in")


ggplot(data, aes(x=phase, y=deltaF_oz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste(Delta,f))) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),
        text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")

ggsave(filename = "vlinPlot_sleep_oz_deltaF_ST7011J.pdf", width = 7, height = 7,
       units = "in")

ggplot(data, aes(x=phase, y=deltaPR_oz, fill=phase)) +
  geom_violin() + geom_boxplot(width=0.1, fill="white") +
  scale_x_discrete(limits=c("Wake","REM","S1","S2","S3","S4")) +
  labs(x="Sleep Phase", y = expression(paste("P(",delta,")"))) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=0.5),text = element_text(size=20)) +
  ylim(0,1.2) + scale_fill_brewer(palette="RdBu") +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position = "none")


ggsave(filename = "vlinPlot_sleep_oz_deltaPR_ST7011J.pdf", width = 7, height = 7,
       units = "in")

plotScMatrix <- dget("plotScMatrix.R")

plotScMatrix(data[,2:7], histogram=TRUE)
