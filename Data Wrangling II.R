# Data Wrangling Exercise 2: Dealing with missing values
# Import and inspect the Titanic csv file
library(utils)
getwd()
setwd("/Users/vijaygopalakrishnan/R Programming")
titanic <- read.csv("/Users/vijaygopalakrishnan/R Programming/titanic3.csv")


titanic
str(titanic)
head(titanic)
summary(titanic)
any(is.na(titanic$embarked))
sum(is.na(titanic$embarked))
complete.cases(titanic)
titanic[complete.cases(titanic), ]
na.omit(titanic)

# 1. Replace port of embarkation, column 'embarked' missing values with 'S"
table(titanic$embarked)
library(stringr)
titanic$embarked <- str_replace(titanic$embarked, "^$", "S")
summary(titanic$embarked)
table(titanic$embarked)


#2. Age column, Missing values
# mean and median are very close and hence missing values can be replaced by either of them.
# Zero is not an option in this case as age cannot be Zero.
mean(titanic$age, na.rm=TRUE)
titanic$age[which(is.na(titanic$age))] <- mean(titanic$age, na.rm = TRUE)
summary(titanic)

# 3. Replace missing values in the field boat with NA
summary(titanic$boat)
titanic$boat <- str_replace(titanic$boat, "^$", NA)
summary(titanic$boat)
table(titanic$boat)


# 4. Cabin Number
sum(is.na(titanic$cabin))
table(titanic$cabin)
levels(titanic$cabin)
# 4.1 Cabin Number is Character and it does not make sense to fill in with a random value
# 4.2 Does the absence of the cabin # mean that those passengers were actually part of the Titanic working crew?
# 4.2 Does this mean that their chances of survival were much lower ?

# Add has_cabin_number field based on values of field cabin. Values 1/0, 0 for NA and 1 for a value in in field cabin

titanic$cabin <- str_replace(titanic$cabin, "^$", NA)
table(titanic$cabin)
sum(is.na(titanic$cabin))
titanic$has_cabin_number <- ifelse(is.na(titanic$cabin), 0, 1)
summary(titanic$has_cabin_number)
tail(titanic)
head(titanic)

# Output the file into a CSV
write.csv(titanic, file = "titanic_clean.csv")

