

# Introduction ------------------------------------------------------------


# example of mathematical equations

3 + 5

# monah is my nam

weight <- "M"

# to execute a function from the script to the console:
# click on Cmd + Enter for Max
# click on Ctrl + Enter for windows

x <- 3
x

weight_kg <- 55
my_name <- "Monah"


# to put the assignment operator: click on Alt + - (windows) and Option + - (Mac)


2.2 * weight_kg
weight_lb <- 2.2 * weight_kg

weight_lb <- 500


# Functions ---------------------------------------------------------------


weight_kg <- sqrt(10)
weight_kg


round(3.1415)

# to get help for a function
?round

round(3.14156, digits = 2)

round(6.325235, digits = 3)

# Vector
weight_g <- c(50,60,30,10,20)
weight_g


animals <- c("cat", "dog", "cow")
animals

class(weight_g)
class(animals)

# we have 3 main main types:
# numeric: 3,4,6
# character: monah, chormosome, car
# logical: TRUE, FALSE

# to add multiple hashtags: click on Shift + Cmd + C

num_char <- c(1,2,3,4,"a")
num_char
class(num_char)
# coercion

chromosomes <- c(1,2,3,4,5,"X")

class(chromosomes)

length(weight_g)
str(weight_g)

weight_g
weight_lb <- weight_g * 2.2
weight_lb



# Subsetting Vectors ------------------------------------------------------


chromosomes <- c(1,3,21,22)
chromosomes

chromosomes[1]
chromosomes[3]

chromosomes[c(1,3)]
chromosomes[c(2,1,3,4)]

chromosomes_rearranged <- chromosomes[c(2,1,3,4)]
chromosomes <- chromosomes[c(2,1,3,4)]

chromosomes[c(1,2,3,2,3,1,4)]
length(chromosomes)
chromosomes[c(1,2,3,2,3,1,4,5)]

genes <- c("RUNX1", "DNMT1", "IFITM3")
genes

genes[c(1,2)]
genes[c(TRUE,FALSE,FALSE)]


weight_g <- c(50,60,30,10,20)
weight_g > 50

weight_g[weight_g > 50]
weight_g[weight_g > 30 & weight_g < 60]
weight_g[weight_g == 30]

genes[genes == "RUNX1"]



# Starting with Data ------------------------------------------------------

# download the data
download.file(url = "https://ndownloader.figshare.com/files/2292169", 
              destfile = "data/portal_data_joined.csv")

# install packages
install.packages(c("tidyverse", "patchwork"))
# run it only once

# to interrupt: click on Esc

# to load libraries
library(tidyverse)
library(patchwork)


# to load the data file
surveys <- read_csv("data/portal_data_joined.csv")

# dataframe = table

# to see the first 6 rows of a dataframe
head(surveys)
View(surveys)
tail(surveys)

?head
head(surveys, n = 20)

## Inspecting the dataframe

dim(surveys)
nrow(surveys)
ncol(surveys)
colnames(surveys)
summary(surveys)


## Subsetting a dataframe

# dataframe[row_index, column_index]
surveys[1,1]
surveys[1,6]
surveys[1,]
surveys[,1]

surveys[c(1,2,3), c(5,6)]
surveys[1:3, 5:11]

head_surveys <- surveys[1:6, ]
head_surveys
# or
head(surveys)

# removing the first column
surveys[,-1]
surveys[-1,]

surveys_wfr <- surveys[-1,]

surveys[-c(1,2,3),]
surveys[,-c(2,3,4)]
# or
surveys[,c("month", "day","year")]

# convert a column to a vector
surveys[["species_id"]]
surveys$species_id


surveys[,]

# Exercise

# 1. Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.

# 2. Notice how nrow() gave you the number of rows in a data.frame?
# Use that number to pull out just that last row from the surveys dataset.
# Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.

# 3. Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.


#1.
surveys_200 <- surveys[200,]

#2.
nrow(surveys)
surveys[34786,]
# or
surveys[nrow(surveys), ]
# or
number_of_rows <- nrow(surveys)
surveys[number_of_rows, ]

tail(surveys, n = 1)

#3.
surveys_middle <- surveys[nrow(surveys) / 2, ]
# or
surveys_middle <- surveys[number_of_rows / 2, ]



species <- surveys$species_id
species


