\name{CPValidity}
\alias{CPValidity}
\title{Computes the deviation from exact validity as the Euclidean norm of
the difference of the observed error and the expected error}
\usage{
CPValidity(matPValues = NULL, testLabels = NULL)
}
\arguments{
\item{matPValues}{Matrix of p-values}

\item{testLabels}{True labels for the test-set}
}
\value{
The deviation from exact validity
}
\description{
Computes the deviation from exact validity as the Euclidean norm of
the difference of the observed error and the expected error
}
\seealso{
  \code{\link{CPCalibrationPlot}},
  \code{\link{CPEfficiency}},
  \code{\link{CPErrorRate}},
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
CPValidity(pValues, testLabels)
}
