# Lanette Tyler
# ST558 Week 3 Practice

# Control Flow: Logicals and if/then/else ------------------------------------------------------------

#Fizz buzz challenge

# take in a number
# if number is divisible by 3 return fizz
# if number is divisible by 5 return buzz
# if number is divisble by 15 return fizz buzz

number <- 1
if ((number %% 15) == 0) {
  print("fizz buzz")
} else if ((number %% 5) == 0) {
  print("buzz")
} else if ((number %% 3) == 0) {
  print("fizz")
} else {
  print("whoops?")
}


# for loops -----------------------------------------------

#simple for loop
words <- c("first", "second", "third", "fourth", "fifth")
data <- runif(5)

for (j in 1:5) {
  print(paste0("The ",words[j]," data point is ",data[j], ".", sep=""))
}

#more complex for loop
#get data to use
install.packages("Lahman")
library(Lahman)
head(Batting)

#subset data
my_batting <- Batting[,c("playerID","teamID","G", "AB", "R", "H", "X2B", "X3B", "HR")]
head(my_batting)

#summarize data
summary(my_batting[,3]) #summarize third column
summary(my_batting[,"HR"]) #summarize column named HR
dim(my_batting) #get dimesnions of df
(dim(my_batting)[2]) #get second dimension of df

#simpler loop to list summaries of numeric columns
for (k in 3:9) {
  print(summary(my_batting[,k]))
}

#loop through/more complex/referencing dim instead of putting in value

for (k in 3:(dim(my_batting))[2]) {
  print(summary(my_batting[,k]))
}

#set up alternative way to end loop
length(my_batting)

for (i in 3:length(my_batting)) {
  print(summary(my_batting[ ,i]))
}

seq_along(my_batting)
seq_along(my_batting)[-1:-2]


#alternative way to end loop
for (i in seq_along(my_batting)[-1:-2]) {
  print(summary(my_batting[,i]))
}

#output results to summary df
#create empty output data frame
summary_df <- data.frame(stat = character(), Min = numeric(),Q1 = numeric(), Median = numeric(), Mean = numeric(), Q3 = numeric(), Max = numeric())
summary_df #look at it

for (i in seq_along(my_batting)[-1:-2]) {
  summary_df[i-2, ] <- c(colnames(my_batting[i]),summary(my_batting[ ,i]))
}
summary_df

# more practice

#make practice data frame:
column1 <- 1:10
column2 <- 11:20
column3 <- 21:30
practice_df <- data.frame(column1,column2,column3)
practice_df

#print summary, two ways
summary(practice_df)
for (i in 1:length(practice_df)) {
  print(summary(practice_df[i]))
}

#write summary to new data frame

#write empty data frame to hold output
sumdf <- data.frame(label = character(), Min = numeric(), Q1 = numeric(), Median = numeric(), Mean = numeric(), Q3 = numeric(), Max = numeric())

#write output to data frame
for (i in 1:length(practice_df)) {
  sumdf[i, ] <- c(colnames(practice_df[i]),summary(practice_df[ ,i]))
}

#Wrap the fizz buzz code from above into a loop to test a sequence of numbers:
for (number in -1:41) {
  if ((number %% 15) == 0) {
    print("fizz buzz")
  } else if ((number %% 5) == 0) {
    print("buzz")
  } else if ((number %% 3) == 0) {
    print("fizz")
  } else {
    print("whoops?")
  }
}

# Odds and ends
#review for loops
for (i in 1:10) {print(i)}

# break out of loop

for (i in 1:10) {
  print(i)
  if (i == 3) break
}

#skip an interation/only do odd numbers though cycling through all
for (i in 1:10) {
  if ((i %% 2) == 0) next
  print(i)
}


# Control Flow: Vectorized Functions ---------------------------------------------------------
# set up data to use (Batting dataset)
library(Lahman) #load package
Batting         #look at data
my_batting <- Batting[ , c(1,4,6:12)]
head(my_batting)

#means of columns
colMeans(my_batting[ ,3:9])

#install and load package to use
install.packages("matrixStats")
library(matrixStats)

#medians of columns
colMedians(as.matrix(my_batting[,3:9]))

# Vectorized ifelse
head(airquality)
ifelse(airquality$Wind >= 15, "High Wind", "not High Wind")

#we can use a second call to ifelse() to assign what to do if the condition is false:
ifelse(airquality$Wind >= 15, "High Wind",
       ifelse(airquality$Wind >= 10,"Windy",
              ifelse(airquality$Wind >= 6,"Light Wind",
                     ifelse(airquality$Wind >= 0, "Calm","Error"))))


#Writing Functions ----------------------------------------------------------

#create a vector of data to use:
set.seed(10)
data <- runif(15)
data

standardize <- function(vector) {
  return((vector - mean(vector))/sd(vector))
}

result <- standardize(data)
result

#check that result has mean 0 and st dev 1:
mean(result)
dplyr::near(0,mean(result))
sd(result)

#Add more inputs to standardize function: make centering optional and make scaling optional
standardize <- function(vector, center, scale) {
  if (center) {
    vector <- vector - mean(vector)
    }
  if (scale) {
    vector <- vector/sd(vector)
    }
  return(vector)
}

result <- standardize(data, center = TRUE, scale = TRUE)
result
mean(result) #should be zero
dplyr::near(0,mean(result)) #should be true
sd(result) #should be one

result <- standardize(data,center=FALSE,scale=TRUE)
result

result <- standardize(data,TRUE,FALSE)
result

#give center and scale default arguments
standardize <- function(vector, center = TRUE, scale = TRUE) {
  if (center) {
    vector <- vector - mean(vector)
    }
  if (scale) {
    vector <- vector/sd(vector)
    }
  return(vector)
  }

result <- standardize(data, center = TRUE, scale = TRUE)
result

#return mean and sd of original data as well:
standardize <- function(vector, center = TRUE, scale = TRUE) {
  mean <- mean(vector) #save value so we can return it
  stdev <- sd(vector) #save so we can return it
  if (center) {
    vector <- vector - mean(vector)
    }
  if (scale) {
    vector <- vector/sd(vector)
    }
  return(list(vector,mean,stdev))
}

standardize(data)
 
# We can also give names to the list elements (fancier)
standardize <- function(vector, center = TRUE, scale = TRUE) {
  mean <- mean(vector) #save value so we can return it
  stdev <- sd(vector) #save so we can return it
  if (center) {
    vector <- vector - mean(vector)
  }
  if (scale) {
    vector <- vector/sd(vector)
  }
  return(list(result = vector,mean = mean, sd = stdev))
}

standardize(data)

#writing functions with stop and switch-----------------------------------------------------------
summarizer <- function(vec, type, trim = 0.05) {
  if(!is.vector(vec) | !is.numeric(vec)) {
    stop("Not a vector or not numeric, my friend")
  }
  switch(type,mean = mean(vec),
              median = median(vec),
              trimmed = mean(vec, trim),
              stop("Mistake!") 
              )
}

#Test it out:
summarizer(letters, "mean")
summarizer(c(1, 1, 1, 6, 10), "mean")
summarizer(c(1, 1, 1, 6, 10),"trimmed",0.2)
summarizer(c(1, 1, 1, 6, 10),"means")

# Input Matching -----------------------------------------------------------
cor #look at inputs for cor function
cor(x = iris$Sepal.Length, y = iris$Sepal.Width)
cor(iris$Sepal.Length,iris$Sepal.Width)
cor(iris$Sepal.Length,iris$Sepal.Width,method = "pearson")
cor(iris$Sepal.Length,iris$Sepal.Width,method = "spearman")

# Infix Functions -----------------------------------------------------------
# simple examples
mean(3:5) # mean is a built-in prefix function, comes before the inputs 
3 + 5 # plus is a built-in infix function, it comes between the inputs
`+`(3, 5) # use back tick marks to make an infix a prefix fnc

#more complex examples
#infix (matrix multiplication %*%)
cars <- as.matrix(cars)
t(cars) %*% cars
`%*%`(t(cars),cars) # use infix fnc as prefix

# write my own infix function
`%+%` <- function(a,b) {
  paste0(a,b)
}
#use my infix function
"new" %+% " string"

# write it a slightly different way
`%+%` <- function(a,b) paste0(a,b)
"new" %+% " string"

# User defined infix function
`%-%` <- function(a, b) {
  paste0("(", a, " %-% ", b, ")")
}
"a" %-% "b"
"a" %-% "b" %-% "c"
#reads from left to right

# Base R pipe ----------------------------------------------------------------------------------------
library(dplyr)
arrange(select(filter(as_tibble(Lahman::Batting),teamID == "PIT"),playerID, G, X2B),desc(X2B))

#this is much simple with a pipe
Lahman::Batting |> 
  as_tibble() |>
  filter(teamID == "PIT") |>
  select(playerID, G, X2B) |>
  arrange(desc(X2B))
