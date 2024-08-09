library(tidyverse)
library(dlookr)
library(caret)
library(missRanger)
library(SmartEDA)
library(DataExplorer)

train.original = read_csv("Titanic/Data/traintitanic.csv")
test.original =  read_csv("Titanic/Data/testtitanic.csv")

test.original$Survived = NA

train.original$IsTrain = TRUE
test.original$IsTrain = FALSE

full.data = rbind(train.original, test.original)

full.data$Sex = as.factor(full.data$Sex)
full.data$Embarked = as.factor(full.data$Embarked)
full.data$Pclass = as.factor(full.data$Pclass)
full.data$SibSp = as.factor(full.data$SibSp)
full.data$Parch = as.factor(full.data$Parch)

SmartEDA::ExpReport(full.data, op_file = "reportEDA.html")
DataExplorer::create_report(full.data)
dlookr::eda_web_report(full.data)
dlookr::diagnose_web_report(full.data)
