# Authors: Lucas França(1), Yujiang Wang(1,2,3)

# 1 Department of Clinical and Experimental Epilepsy, UCL Institute of Neurology,
# University College London, London, United Kingdom

# 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research group,
# School of Computing Science, Newcastle University, Newcastle upon Tyne,
# United Kingdom

# 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
# United Kingdom

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

ggsave(filename = "effSize_Study 040.pdf", width = 9, height = 6.32, units = "in", useDingbats = F)
