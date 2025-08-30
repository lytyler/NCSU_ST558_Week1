# NCSU 558 Week 2
# Matrices

## Create a matrix
my_matrix <- matrix(c(1,3,4,-1,5,6),nrow=3,ncol=2)
my_matrix
#fills one column, then the next b/c default is byrow=FALSE

#try filling the matrix the other way:
my_matrix <- matrix(c(1,3,4,-1,5,6),nrow=3,ncol=2,byrow=TRUE)
my_matrix

#can also create matrices by forming rows or columns (as vectors) and combining them:
x <- (rep(0.2, times = 6))
x
x <- (rep(0.2,6))
x
y <- c(1,3,4,-1,5,6)
y

#check data structures of the vectors/type/etc., and length
str(x)
str(y)
is.numeric(x)
is.numeric(y)
length(x)
length(y)

# Combine vectors x and y into a matrix:
my_matrix2 <- matrix(c(x,y), ncol=2)
my_matrix2
as.vector(my_matrix2)

# Matrices do not have to be numeric:
# FOrm three char vectors to form into matrix
x <- c("Lanette", "Young","Tyler")
y <- c("Jonathan","Bradley","Tyler")
z <- c("Jane","Esther","Tyler")
x
y
z

matrix(c(x,y,z),nrow=3)
matrix(c(x,y,z))

# Create a 2x2 matrix of 0's:
matrix(0,nrow=2,ncol=2)


#Matrices have attributes: dim and dimnames:
my_iris <- as.matrix(iris[,1:4])
str(my_iris)
head(my_iris)
tail(my_iris)
attributes(my_iris)
dim(my_iris)
dimnames(my_iris)

#Assign dimnames using a list
dimnames(my_iris) <- list(1:150,c("Sepal Length","Sepal Width","Petal Length","Petal Width"))
head(my_iris)
tail(my_iris)

#Assign dimnames at creation of matric:
my_matrix3 <- matrix(c(runif(10),rnorm(10),rgamma(10,shape=1,scale=1)),nrow=10,dimnames=list(1:10,c("Uniform","Normal","Gamma")))
my_matrix3

# Accessing ELements of a matrix:
my_matrix4 <- matrix(c(1:4,20:17),ncol=2)
my_matrix4
my_matrix4[2,2]
my_matrix4[,1]
my_matrix4[4,]
my_matrix4[2:4,1]
my_matrix4[c(2,4),]
dimnames(my_matrix4) <- list(NULL,c("First","Second"))
my_matrix4

# can also reference matrix elements by dimnames:
my_matrix4[,"First"]
dim(my_matrix4)

##Arrays
my_array <- array(1:24,dim=c(4,2,3))
my_array
my_array[3,1,2]
