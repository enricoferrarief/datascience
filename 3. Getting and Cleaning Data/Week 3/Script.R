# Libraries
library(xlsx)
library(httr)
library(XML)
library(data.table)
library(jsonlite)
library(sqldf)
library(read.fwf)
library(jpeg)
library(dplyr)
library(reshape2)
library(Hmisc)

# Working Directory
setwd("/Users/enricoferrari/datascience/3. Getting and Cleaning Data/Week 3")

# Question 1

# Create Data Directory
If (!file.exists("Question 1")) {
    dir.create("Question 1")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./Question 1/data.csv", method = "curl")
list.files("./Question 1/")

# Read File in R
data <- read.csv("Question 1/data.csv")

# Answer
agricultureLogical <- data$ACR == 3 & data$AGS == 6

answer <- head(which(agricultureLogical), n=3)

# Question 2

# Create Data Directory
If (!file.exists("Question 2")) {
    dir.create("Question 2")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="./Question 2/image.jpg", method = "curl")
list.files("./Question 2/")

image = readJPEG("./Question 2/image.jpg",native = TRUE)

# Answer

answer <- c(quantile(image,0.3),quantile(image,0.8))

# Question 3

# Create Data Directory
If (!file.exists("Question 3")) {
    dir.create("Question 3")
}

# Download File
fileUrlA <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrlA, destfile="./Question 3/dataA.csv", method = "curl")

fileUrlB <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrlB, destfile="./Question 3/dataB.csv", method = "curl")

list.files("./Question 3/")

# Read File in R
dataA <- read.csv("Question 3/dataA.csv",skip = 3, stringsAsFactors = FALSE)
dataB <- read.csv("Question 3/dataB.csv")

# Filter of dataA dataset where ranking is existent

dataA <- dataA[dataA$Ranking != "",]

# Data Merge

answer <- merge(dataA, dataB, by.x = "X", by.y = "CountryCode", all = FALSE)

answer3 <- arrange(answer,desc(as.numeric(levels(Ranking)[Ranking])))


# Question 4

answer4 <- tapply(as.numeric(levels(answer3$Ranking)[answer3$Ranking]),answer3$Income.Group,mean)

# Question 5

rankingGroups <- cut(as.numeric(levels(answer3$Ranking)[answer3$Ranking]), 5)

rankingTables <- table(rankingGroups,answer3$Income.Group)