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

Age_outliers_limit = boxplot.stats(train.original$Age)$stats[5]

train.original <- train.original %>%
  filter(train.original$Age < Age_outliers_limit)

Fare_outliers_limit = boxplot.stats(train.original$Fare)$stats[5]

train.original <- train.original %>%
  filter(train.original$Fare < Fare_outliers_limit)

full.data = rbind(train.original, test.original)

SmartEDA::ExpReport(full.data, op_file = "reportEDA.html")

DataExplorer::create_report(full.data)
dlookr::eda_web_report(full.data)
dlookr::diagnose_web_report(full.data)


full.data$Cabin = NULL

full.data$Embarked[is.na(full.data$Embarked)] = "S"

full.data$Fare[is.na(full.data$Fare)] = median(full.data$Fare)

full.data$Sex = as.factor(full.data$Sex)
full.data$Embarked = as.factor(full.data$Embarked)
full.data$Pclass = as.factor(full.data$Pclass)
full.data$SibSp = as.factor(full.data$SibSp)
full.data$Parch = as.factor(full.data$Parch)

Fare_outliers_limit_full = boxplot.stats(full.data$Fare)$stats[5]

full.data <- full.data %>%
  filter(full.data$Fare < Fare_outliers_limit_full)

full.data.nosurvived = full.data

full.data.nosurvived$Survived = NULL

full.data.nosurvived %>% is.na() %>% colSums()

full.data.nosurvived.clean = full.data.nosurvived %>% missRanger(
  formula = Age ~ ., num.trees = 1000
)

full.data.nosurvived.clean %>% is.na() %>% colSums()

new.full.data = full.data.nosurvived.clean

new.full.data$Survived = full.data$Survived

new.full.data %>% is.na() %>% colSums()

train.clean = new.full.data%>% filter(IsTrain == TRUE)

test.clean = new.full.data %>% filter(IsTrain == FALSE)

train.clean$IsTrain = NULL

test.clean$IsTrain = NULL

