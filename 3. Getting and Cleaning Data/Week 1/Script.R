# Libraries
library(xlsx)
library(XML)
library(data.table)

# Working Directory
setwd("/Users/enricoferrari/datascience/3. Getting and Cleaning Data/Week 1")

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
Data <- read.csv("Question 1/data.csv")

Answer <- sum(Data$VAL >= 24, na.rm=T)

# Question 3

# Create Data Directory
If (!file.exists("Question 3")) {
    dir.create("Question 3")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./Question 3/data.csv", method = "curl")
list.files("./Question 3/")

# Read File in R
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./Question 3/data.csv",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)

Answer <- sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4

# Create Data Directory
If (!file.exists("Question 4")) {
    dir.create("Question 4")
}

# Read File in R
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=T)
rootNode <-xmlRoot(doc)
xmlName(rootNode)

Data <- xpathSApply(rootNode,"//zipcode",xmlValue)

Answer <- sum(Data == 21231)

# Question 5

# Create Data Directory
If (!file.exists("Question 5")) {
    dir.create("Question 5")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./Question 5/data.csv", method = "curl")
list.files("./Question 5/")

# Read File in R
DT <- fread("./Question 5/data.csv")

# Method 1
system.time(DT[,mean(pwgtp15),by=SEX])[1]

# Method 2
system.time(tapply(DT$pwgtp15,DT$SEX,mean))[1]

# Method 3
system.time(mean(DT$pwgtp15,by=DT$SEX))[1]

# Method 4
system.time(mean(DT[DT$SEX==1,]$pwgtp15))[1] + system.time(mean(DT[DT$SEX==2,]$pwgtp15))[1]

# Method 5
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[1]

# Method 6
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])[1]



