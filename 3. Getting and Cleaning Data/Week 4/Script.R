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
library(lubridate)

# Working Directory
setwd("/Users/enricoferrari/datascience/3. Getting and Cleaning Data/Week 4")

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
data1 <- read.csv("Question 1/data.csv")

# Answer
names <- sapply(names(data1),strsplit,"wgtp")

answer1 <- names[123]

# Question 2

# Create Data Directory
If (!file.exists("Question 2")) {
    dir.create("Question 2")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./Question 2/data.csv", method = "curl")
list.files("./Question 2/")

# Read File in R
data2 <- read.csv("Question 2/data.csv", skip = 4, col.names = c("CountryCode","Ranking","v3","Economy","USDollars","v6","v7","v8","v9","v10"), stringsAsFactors = FALSE)

data2 <- data2[data2$Ranking %in% 1:190,]

# Answer
answer2 <- mean(as.numeric(gsub(",","",data2$USDollars)),na.rm = TRUE)

# Question 3

answer3 <- grep("^United",data2$Economy)

# Question 4

# Create Data Directory
If (!file.exists("Question 4")) {
    dir.create("Question 4")
}

# Download File
fileUrlA <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrlA, destfile="./Question 4/dataA.csv", method = "curl")

fileUrlB <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrlB, destfile="./Question 4/dataB.csv", method = "curl")

list.files("./Question 4/")

# Read File in R
dataA <- read.csv("Question 4/dataA.csv",skip = 4, col.names = c("CountryCode","Ranking","v3","Economy","USDollars","v6","v7","v8","v9","v10"), stringsAsFactors = FALSE)
dataB <- read.csv("Question 4/dataB.csv")

# Filter of dataA dataset where ranking is existent and dataB where end of fiscal year is not available

dataA <- dataA[dataA$Ranking != "",]

dataB <- dataB[dataB$Special.Notes != "",]

# Data Merge

dataMerge <- merge(dataA, dataB, by.x = "CountryCode", by.y = "CountryCode", all = FALSE)

# Answer 4

answer4 <- length(grep("^Fiscal year end: June",dataMerge$Special.Notes))

# Question 5

library(quantmod)

amzn = getSymbols("AMZN",auto.assign=FALSE)

sampleTimes = index(amzn)

answer5A <- sum(year(sampleTimes) == 2012)

answer5B <- sum(year(sampleTimes) == 2012 & wday(sampleTimes, label = TRUE) == "Mon")
