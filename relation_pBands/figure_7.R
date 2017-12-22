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

library(R.matlab)

my_data <- readMat("iEEG_pBands.mat")

a <- data.frame(my_data$bMat)

colnames(a) <- c("Width*","Height*",expression(delta),expression(theta),
                 expression(alpha), expression(beta), expression(gamma))

plotScMatrix <- dget("plotScMatrix.R")

plotScMatrix(a, histogram=TRUE)
