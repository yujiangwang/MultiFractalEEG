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
                       name="Pearson\nCorrelation") +
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
    legend.direction = "horizontal") +
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

# ggsave(ggheatmap, filename=paste("fancyCorM_",nm,".eps",sep=""), width = 10,
#        height = 10, units = c("in"))
# ggsave(ggheatmap, filename=paste("fancyCorM_",nm,".png",sep=""), width = 10,
#        height = 10, units = c("in"), dpi = 300)
