best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if(!state %in% data$State) {
        stop("invalid state")
    } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia") ){
        stop("invalid outcome")
    }
        
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    columnNumber <- if(identical(outcome,"heart attack")) {
        11
    } else if (identical(outcome,"heart failure")) {
        17
    } else if (identical(outcome,"pneumonia")) {
        23
    }
    
    orderedData <- data[order(data$Hospital.Name) & data$State == state & !is.na(as.numeric(data[,columnNumber])),]
    
    output <- orderedData$Hospital.Name[as.numeric(orderedData[,columnNumber]) == min(as.numeric(orderedData[,columnNumber]))]
    
    output[1]
}