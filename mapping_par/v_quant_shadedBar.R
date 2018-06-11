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
library(R.matlab)
library(reshape2)

Q <- readMat("quantiles.mat")
Q <- data.frame(Q$quantMat)

names(Q) <- c("v", "sign0.1", "sign0.5", "sign0.9", "rand0.1",
              "rand0.5", "rand0.9", "surr0.1", "surr0.5", "surr0.9")

val <- data.frame(Q$v,Q$sign0.5,Q$rand0.5,Q$surr0.5)
names(val) <- c("v", "sign", "rand", "surr")
errP <- data.frame(Q$v,Q$sign0.9,Q$rand0.9,Q$surr0.9)
names(errP) <- c("v", "sign", "rand", "surr")
errM <- data.frame(Q$v,Q$sign0.1,Q$rand0.1,Q$surr0.1)
names(errM) <- c("v", "sign", "rand", "surr")

val <- melt(val, id = "v")
errP <- melt(errP, id = "v")
errM <- melt(errM, id = "v")

R <- cbind(val, data.frame(errM$value),data.frame(errP$value))

ggplot(data = R, aes(x = v, y = value, color = as.factor(variable))) +
  geom_line(size = 2) + geom_ribbon(aes(ymin=errM.value, ymax=errP.value,
                                fill = as.factor(variable)), alpha=0.4) +
  scale_color_manual(values = c("#ca0020", "#0571b0", "#92c5de")) +
  scale_fill_manual(values = c("#ca0020", "#0571b0", "#92c5de")) +
  theme_bw(base_size = 20) +
  theme(panel.border = element_rect(size = 2)) +
  theme(legend.position="none") + ylab(expression(paste(Delta, alpha)))
