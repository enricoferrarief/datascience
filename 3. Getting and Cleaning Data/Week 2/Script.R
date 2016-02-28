# Libraries
library(xlsx)
library(httr)
library(XML)
library(data.table)
library(jsonlite)
library(sqldf)
library(read.fwf)

# Working Directory
setwd("/Users/enricoferrari/datascience/3. Getting and Cleaning Data/Week 2")


# Question 1

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "0e0569146c7227ee0081",
                   secret = "721fbfd39f975f339271df16a83d7b937cd935e4")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
data <- fromJSON("https://api.github.com/users/jtleek/repos")

answer <- data$created_at[data$name == "datasharing"]

# Question 2

# Create Data Directory
If (!file.exists("Question 2")) {
    dir.create("Question 2")
}

# Download File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./Question 2/data.csv", method = "curl")
list.files("./Question 2/")

# Read File in R
acs <- read.csv("Question 2/data.csv")

# Question 4

# Download File
fileUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
con=url(fileUrl)
htmlCode = readLines(con)
close(con)
lines <- c(10,20,30,100)

answer <- nchar(htmlCode[lines])

# Question 5

# Create Data Directory
If (!file.exists("Question 5")) {
    dir.create("Question 5")
}

# Read File in R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="./Question 5/data.for", method = "curl")
list.files("./Question 5/")

data <- read.fwf("./Question 5/data.for",skip=4,
                 widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))

answer <- sum(data$V4) + sum(data$V9)
