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
