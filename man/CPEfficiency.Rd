\name{CPEfficiency}
\alias{CPEfficiency}
\title{Computes efficiency of a conformal predictor, which is defined as the
ratio of predictions with more than one class over the size of the testset}
\usage{
CPEfficiency(matPValues, testLabels, sigfLevel = 0.05)
}
\arguments{
\item{matPValues}{Matrix of p-values}

\item{testLabels}{True labels for the test-set}

\item{sigfLevel}{Significance level}
}
\value{
The efficiency
}
\description{
Computes efficiency of a conformal predictor, which is defined as the
ratio of predictions with more than one class over the size of the testset
}
\seealso{
  \code{\link{CPCalibrationPlot}},
  \code{\link{CPErrorRate}},
  \code{\link{CPValidity}},
  \code{\link{CPObsFuzziness}}.
}
\examples{
## load the library
library(mlbench)
#library(caret)
library(conformalClassification)

## load the DNA dataset
data(DNA)
originalData <- DNA

## make sure first column is always the label and class labels are always 1, 2, ...
nrAttr = ncol(originalData) #no of attributes
tempColumn = originalData[, 1]
originalData[, 1] = originalData[, nrAttr]
originalData[, nrAttr] = tempColumn
originalData[, 1] = as.factor(originalData[, 1])
originalData[, 1] = as.numeric(originalData[, 1])

## partition the data into training and test set
#result = createDataPartition(originalData[, 1], p = 0.8, list = FALSE)
size = nrow(originalData)
result = sample(1:size,  0.8*size)

trainingSet = originalData[result, ]
testSet = originalData[-result, ]

##ICP classification
pValues = ICPClassification(trainingSet, testSet)
testLabels = testSet[,1]
CPEfficiency(pValues, testLabels)
}
