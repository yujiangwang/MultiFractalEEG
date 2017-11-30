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
