rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if(!state %in% data$State) {
        stop("invalid state")
    } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia") ){
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the given rank
    columnNumber <- if(identical(outcome,"heart attack")) {
        11
    } else if (identical(outcome,"heart failure")) {
        17
    } else if (identical(outcome,"pneumonia")) {
        23
    }
    
    
    orderedData <- data[order(as.numeric(data[,columnNumber]),data$Hospital.Name),]
    
    relevantData <- orderedData[orderedData$State == state & !is.na(as.numeric(orderedData[,columnNumber])),]
    
    #output <- orderedData$Hospital.Name[as.numeric(orderedData[,columnNumber]) == min(as.numeric(orderedData[,columnNumber]))]
    
    output <- if(num == "best") {
        relevantData$Hospital.Name[1]
    } else if (num == "worst") {
        relevantData$Hospital.Name[length(relevantData$Hospital.Name)]
    } else {
        relevantData$Hospital.Name[num]
    }
    
    output
    
    ## 30-day death rate
}