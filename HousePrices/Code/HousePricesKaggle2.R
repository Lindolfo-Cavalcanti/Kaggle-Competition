# Load necessary libraries
library(tidyverse)
library(randomForest)

# Step-by-step Titanic Kaggle solution

# 1- Load data correctly (stringsAsFactors = FALSE)

train_data <- read.csv("/home/lindo/Documents/Kaggle/TitanicKaggle/train.csv", stringsAsFactors = FALSE)
test_data <- read.csv("/home/lindo/Documents/Kaggle/TitanicKaggle//test.csv", stringsAsFactors = FALSE)

# 2- Data Cleaning

# Ensure columns match between train and test data
str(c(train_data, test_data))

# Add Survived column to test data
test_data$Survived <- NA

# Combine train and test datasets for uniform processing
train_data$IsTrain <- TRUE
test_data$IsTrain <- FALSE

full_data <- rbind(train_data, test_data)
glimpse(full_data)

# Handle NA values without removing rows
table(is.na(full_data)) # 682 NAs in the entire dataset

# Check and replace NA values in Age
table(is.na(full_data$Age)) # 263 NAs in Age
AgeMedian <- median(full_data$Age, na.rm = TRUE)
full_data <- full_data %>% mutate(Age = ifelse(is.na(Age), AgeMedian, Age))

# Check and replace NA values in Fare
table(is.na(full_data$Fare)) # 1 NA in Fare
FareMedian <- median(full_data$Fare, na.rm = TRUE)
full_data <- full_data %>% mutate(Fare = ifelse(is.na(Fare), FareMedian, Fare))

# Convert Pclass, Sex, and Embarked to factors
full_data$Pclass <- as.factor(full_data$Pclass)
full_data$Sex <- as.factor(full_data$Sex)
full_data$Embarked <- as.factor(full_data$Embarked)

# Separate combined data back into train and test datasets
train_data_tratado <- full_data %>% filter(IsTrain == TRUE)
train_data_tratado$IsTrain <- NULL

test_data_tratado <- full_data %>% filter(IsTrain == FALSE)
test_data_tratado$IsTrain <- NULL

# Convert Survived column to factor in training data
train_data_tratado$Survived <- as.factor(train_data_tratado$Survived)

# 3- Create model

# Define formula for the model
survived_solution <- "Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
survived_formula <- as.formula(survived_solution)

# Create Random Forest model
model <- randomForest(formula = survived_formula, data = train_data_tratado, ntree = 500, mtry = 3, 
                      nodesize = 0.01 * nrow(train_data_tratado))

# 4- Apply model

# Predict Survived using the model on test data
solution_titanic <- predict(model, newdata = test_data_tratado)
table(solution_titanic)

# 5- Create output

# Create a dataframe with PassengerId and Survived
PassengerId <- test_data_tratado$PassengerId
output <- as.data.frame(PassengerId)
output$Survived <- solution_titanic

# Export the result to a CSV file
write.csv(output, file = "titanic_submission.csv", row.names = FALSE)