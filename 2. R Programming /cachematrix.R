## The functions makeCacheMatrix and cacheSolve will allow you to cache the inverse of
## a matrix, which often is a time consuming computation.

## This function will create a special vector which is a list of four functions to:
## 1. set the value of a matrix
## 2. get the value of the matrix
## 3. set the inverse of the matrix
## 4. get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
        ## the function takes x as a matrix as input
        
        m <- NULL
        ## it creates a variable which has value NULL
        
        set <- function(y) {
            x <<- y
            m <<- NULL
            ## set is a function which caches the value of x and m through the assignment operator <<-
        }
        
        get <- function() x
        ## get is a function which returns the matrix x
        
        setinverse <- function(solve) m <<- solve
        ## setinverse is a function which assign its input to m and caches its value
        
        getinverse <- function() m
        ## getinverse is a function which returns the inverse of the matrix cached within the variable m
        
        list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
        ## the output of the function is a list containing the four functions explained above
}


## The following function returns the inverse of the matrix which is either cached within the special "vector" created above
## or calculated through the function. The function checks first to see if the inverse has already been calculated. If so, it gets the inverse from the cache
## and skips the computation. Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
        ## The function takes as an input the special vector calculated above
        
        m <- x$getinverse()
        ## It gets the value cached through the function getinverse
        
        if(!is.null(m)) {
            message("getting cached data")
            return(m)
        }
        ## The if structured is used to check whether the cached value of the inverse is not null.
        ## In such case, the functions stops here and returns the cached value.
        
        data <- x$get()
        ## If instead the value is null, the function gets the value of the matrix through the function get
        
        m <- solve(data, ...)
        ## Then, it computes its inverse
        
        x$setinverse(m)
        ## It caches the value of the inverse via the function setinverse
        
        m
        ## And finally returns the value of the inverse
}
