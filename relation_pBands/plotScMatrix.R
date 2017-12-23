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

#' @param R data for the x axis, can take matrix,vector, or timeseries
#' @param histogram TRUE/FALSE whether or not to display a histogram
#' @param method a character string indicating which correlation coefficient
#'           (or covariance) is to be computed.  One of "pearson"
#'           (default), "kendall", or "spearman", can be abbreviated.
#' @param colourHist Colour of the histograms on the diagonal. If not given
#'                   standard "#ca0020" will be used.
#' @param colourSigns Colour of the p-value indicators. If not given
#'                   standard "#ca0020" will be used.
#' @param colourCor Colour of the correlation coefficient. If not given
#'                   standard "#0571b0" will be used.
#' @param colourSc Colour of the scatter plots. If not given
#'                   standard "#0571b0" will be used.
#' @param \dots any other passthru parameters into \code{\link{pairs}}
#' @note based on plot at
#' \url{http://addictedtor.free.fr/graphiques/sources/source_137.R}
#' # Original version from R Development Core Team
#' modified by Peter Carl
#' @author Lucas França
#' @seealso \code{\link{table.Correlation}}
###keywords ts multivariate distribution models hplot
#' @examples
#'
#' data(managers)
#' chart.Correlation(managers[,1:8], pch="+")
#'
#' @export
#'
plotScMatrix <-
  function (x, method=c("pearson", "kendall", "spearman"),
            colourHist, colourSigns, colourCor, colourSc, ...)
  {
    # @author Lucas França
    # Original version from R Development Core Team
    # modified by Peter Carl
    # Visualization of a Correlation Matrix.

    # HANDLING INPUT

    #x = checkData(R, method="matrix")

    library(scales)

    if(missing(method)) method=method[1] #only use one
    if(missing(colourHist)) colourHist = "#ca0020"
    if(missing(colourSigns)) colourSigns = "#ca0020"
    if(missing(colourCor)) colourCor = "#0571b0"
    if(missing(colourSc)) colourSc = "#0571b0"

    # THE ORIGINAL VERSION OF THIS FUNCTION WAS INSPIRED BY:
    # Published at http://addictedtor.free.fr/graphiques/sources/source_137.R

    panel.cor <- function(x, y, digits=2, prefix="", use="pairwise.complete.obs",
                          method, cex.cor, ...)
    {
      usr <- par("usr"); on.exit(par(usr))
      par(usr = c(0, 1, 0, 1))
      r <- cor(x, y, use=use, method=method) # MG: remove abs here
      txt <- format(c(r, 0.123456789), digits=digits)[1]
      txt <- paste(prefix, txt, sep="")
      if(missing(cex.cor)) cex <- 0.8/strwidth(txt)

      # p-value MARKINGS

      test <- cor.test(x,y, method=method)
      Signif <- symnum(test$p.value, corr = FALSE, na = FALSE,
                       cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                       symbols = c("***", "**", "*", ".", " "))

      # MG: add abs here and also include a 30% buffer for small numbers

      # CORRELATION COEFFICIENTS

      text(0.5, 0.5, txt, cex = cex * (abs(r) + .3) / 1.3,
           col=colourCor)
      text(.7, .8, Signif, cex=cex, col=colourSigns)
    }

    # CREATING THE HISTOGRAMS ON THE DIAGONAL

    f <- function(t) {
      dnorm(t, mean=mean(x), sd=sd.xts(x) )
    }
    hist.panel = function (x, ...) {
      par(new = TRUE)
      hist(x,
           col = colourHist,
           border = colourHist,
           probability = TRUE,
           axes = FALSE,
           main = "",
           breaks = "FD")

    }

    # PLOTTING THE CHART
    pairs(x, gap=0, upper.panel=panel.cor, diag.panel=hist.panel,
          method=method, pch=19, col = alpha(colourSc, 0.2), ...)
  }



###############################################################################
#  Lucas França
# This is a modified version from an function originally written by:
# R (http://r-project.org/) Econometrics for Performance and Risk Analysis
#
# Copyright (c) 2004-2014 Peter Carl and Brian G. Peterson
#
# This R package is distributed under the terms of the GNU Public License (GPL)
#
# $Id: chart.Correlation.R 3528 2014-09-11 12:43:17Z braverock $
#
###############################################################################
