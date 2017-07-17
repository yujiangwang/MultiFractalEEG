swSpotDataFrame <- function(matFile,patName){
library(R.matlab)
library(reshape2)

a <- readMat(matFile)
effSize <- a$effSize
dimnames(effSize) <- list(as.character(a$sampRates),
                          as.character(a$szNum),
                          as.character(a$wSizes))

vecEffSize <- melt(effSize)
timeAnal <- vecEffSize$Var3/vecEffSize$Var1
patName <- replicate(n = length(timeAnal), patName)
vecEffSize <- cbind(vecEffSize, timeAnal, patName)

names(vecEffSize) <- c("sampRate", "Seizure", "winSize", "values",
                       "timeAnal", "patName")

return(vecEffSize)

}
