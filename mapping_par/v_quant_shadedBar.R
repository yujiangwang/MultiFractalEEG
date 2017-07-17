rm(list = ls())
library(ggplot2)
library(R.matlab)
library(reshape2)
library(extrafont)

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
  theme(text=element_text(family="Times New Roman")) +
  theme(panel.border = element_rect(size = 2)) + 
  theme(legend.position="none") + ylab(expression(paste(Delta, alpha)))
