## Begin

install.packages("dplyr")

run_analysis <- function(directory)

library(dplyr)
    
setwd("/Users/enricoferrari/datascience")

features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
labels <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

labelname <- "Label"
subjectname <- "Subject"

trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=labelname)
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names = features$V2)
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = subjectname)

testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=labelname)
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names = features$V2)
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = subjectname)

trainDataset <- cbind(trainSubjects,trainLabels,trainData)
testDataset <- cbind(testSubjects,testLabels,testData)

datasets <- rbind(testDataset,trainDataset)

datasetsSubset <- cbind(select(datasets,Label:Subject),select(datasets,contains(".mean")),select(datasets,contains(".std")))


