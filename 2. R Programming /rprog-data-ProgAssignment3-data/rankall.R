rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if(!outcome %in% c("heart attack", "heart failure", "pneumonia") ){
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
    
    
    orderedData <- data[order(as.numeric(data[,columnNumber]),data$State,data$Hospital.Name),]
    
    output <- data.frame(hospital=character(),state=character())
    
    for (state in sort(unique(orderedData$State))){
        
        relevantData <- orderedData[orderedData$State == state,]
        
        hospital <- if(num == "best") {
            relevantData$Hospital.Name[1]
        } else if (num == "worst") {
            relevantData$Hospital.Name[length(relevantData$Hospital.Name)]
        } else {
            relevantData$Hospital.Name[num]
        }
        
        output <- rbind(output, data.frame(hospital = hospital, state = state))
        
    }
    
    output
    
    ## 30-day death rate
}