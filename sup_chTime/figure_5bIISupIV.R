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

library(ggplot2)
library(RColorBrewer)


swSpotDataFrame <- dget("swSpotDataFrame.R")

swSpot <- swSpotDataFrame("effSize_Study 040_ch_1.mat","1")

temp <-swSpotDataFrame("effSize_iStudy 040_ch_1.mat","1")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame("effSize_i2Study 040_ch_1.mat","1")
swSpot <- rbind(swSpot, temp)


temp <- swSpotDataFrame(paste("effSize_Study 040_ch_2.mat",
                              sep=""),"2")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_2.mat",
                             sep=""),"2")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_2.mat",
                             sep=""),"2")
swSpot <- rbind(swSpot, temp)

temp <- swSpotDataFrame(paste("effSize_Study 040_ch_3.mat",
                              sep=""),"3")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_3.mat",
                             sep=""),"3")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_3.mat",
                             sep=""),"3")
swSpot <- rbind(swSpot, temp)

temp <- swSpotDataFrame(paste("effSize_Study 040_ch_4.mat",
                              sep=""),"4")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_4.mat",
                             sep=""),"4")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_4.mat",
                             sep=""),"4")
swSpot <- rbind(swSpot, temp)

temp <- swSpotDataFrame(paste("effSize_Study 040_ch_43.mat",
                              sep=""),"43")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_43.mat",
                             sep=""),"43")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_43.mat",
                             sep=""),"43")
swSpot <- rbind(swSpot, temp)

temp <- swSpotDataFrame(paste("effSize_Study 040_ch_44.mat",
                              sep=""),"44")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_44.mat",
                             sep=""),"44")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_44.mat",
                             sep=""),"44")
swSpot <- rbind(swSpot, temp)

temp <- swSpotDataFrame(paste("effSize_Study 040_ch_45.mat",
                              sep=""),"45")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_iStudy 040_ch_45.mat",
                             sep=""),"45")
swSpot <- rbind(swSpot, temp)
temp <-swSpotDataFrame(paste("effSize_i2Study 040_ch_45.mat",
                             sep=""),"45")
swSpot <- rbind(swSpot, temp)

ggplot(data = swSpot, aes(x = timeAnal, y = values, color = patName)) +
  geom_point(data = swSpot, aes(shape = as.factor(sampRate)), size = 3) +
  scale_shape_manual(values=1:nlevels(as.factor(swSpot$sampRate))) +
  ylim(c(-0.5,1)) + xlim(c(0, 4.5)) + theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.background = element_rect(fill="white",
                                         size=1, linetype="solid",
                                         colour ="black")) +
  geom_smooth(se=FALSE, size = 2) +
  scale_color_manual(values = brewer.pal(7,"RdBu")) +
  xlab('Time (s)') + ylab('Effect Size') +
  labs(color = "Channel") + labs(shape = "Sampling Rate (Hz)") +
  theme(legend.title = element_text(size = 16),
        legend.text = element_text(size = 14))

ggsave(filename = "effSize_Study 040.pdf", width = 10.27, height = 7.24, units = "in", useDingbats = F)
