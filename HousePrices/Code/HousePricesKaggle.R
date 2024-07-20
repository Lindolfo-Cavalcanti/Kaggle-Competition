library(tidyverse)

library(randomForest)

library(e1071)

test_house = read.csv("/home/lindo/Documents/Kaggle/HousePricesKaggle/test.csv")

train_house = read.csv("/home/lindo/Documents/Kaggle/HousePricesKaggle/train.csv")

str(train_house)

# 1 - Data Exploration

# train NA = LotFrontage (median or regression), Alley (None), BSM (None), FireplaceQu (None), 
# GarageType (None), GarageYrBlt (Median or regression), GarageFinish (None), GarageQual (None), 
# GarageCond (None), PoolQc (None), Fence (None), MiscFeature (None).

# test NA = LotFrontage, Alley, MasVnrType (mode or classification), 
# MasVnrTypeArea (median or regression), BSM (None), FirePlaceQu (None), GarageType (None), 
# GarageYrBlt (median or regression) GarageFinish (None), GarageQual (None), GarageCond (None), 
# PoolQc (None), Fence (None), MiscFeature (None).

# 2- Data Cleaning

# Same Columns

ncol(test_house) #80
ncol(train_house) #81 

test_house$SalePrice = NA

train_house$IsTrain = T
test_house$IsTrain = F
glimpse(test_house$IsTrain)
glimpse(train_house$IsTrain)

#Juntar tabelas (rbind())

full_house = rbind(test_house, train_house)
unique(full_house$PoolQC)

# As Factor

str(full_house)

convert_to_factor <- function(data, var_list) {
  for (var in var_list) {
    if (var %in% names(data)) {
      data[[var]] <- as.factor(data[[var]])
    } else {
      warning(paste("Variável", var, "não encontrada no dataframe."))
    }
  }
  return(data)
}

var_list = c('')

# Na to None

# Alley (None)

full_house$Alley[is.na(full_house$Alley)] = "None"
unique(full_house$Alley)

# BSM (None)

full_house$BsmtQual[is.na(full_house$BsmtQual)] = "None"
unique(full_house$BsmtQual)

full_house$BsmtCond[is.na(full_house$BsmtCond)] = "None"
unique(full_house$BsmtCond)

full_house$BsmtExposure[is.na(full_house$BsmtExposure)] = "None"
unique(full_house$BsmtExposure)

full_house$BsmtFinType1[is.na(full_house$BsmtFinType1)] = "None"
unique(full_house$BsmtFinType1)

full_house$BsmtFinType2[is.na(full_house$BsmtFinType2)] = "None"
unique(full_house$BsmtFinType2)

# GarageFinish (None)

full_house$GarageFinish[is.na(full_house$GarageFinish)] = "None"
unique(full_house$GarageFinish)

# Updating NA values in the GarageQual column
full_house$GarageQual[is.na(full_house$GarageQual)] <- "None"
unique(full_house$GarageQual)

# Updating NA values in the GarageType column
full_house$GarageType[is.na(full_house$GarageType)] <- "None"
unique(full_house$GarageType)

# Updating NA values in the GarageCond column
full_house$GarageCond[is.na(full_house$GarageCond)] <- "None"
unique(full_house$GarageCond)

# Updating NA values in the PoolQc column
full_house$PoolQC[is.na(full_house$PoolQC)] <- "None"
unique(full_house$PoolQC)

# Updating NA values in the Fence column
full_house$Fence[is.na(full_house$Fence)] <- "None"
unique(full_house$Fence)

# Updating NA values in the MiscFeature column
full_house$MiscFeature[is.na(full_house$MiscFeature)] <- "None"
unique(full_house$MiscFeature)

# Updating NA values in the FireplaceQu column
full_house$FireplaceQu[is.na(full_house$FireplaceQu)] <- "None"
unique(full_house$FireplaceQu)

str(full_house)

# Define the columns with NA values
columns_with_na <- c("MSZoning", "Utilities", "Exterior1st", "Exterior2nd", "MasVnrType",
                     "BsmtFinSF1", "BsmtFinSF2", "BsmtUnfSF", "TotalBsmtSF",
                     "Electrical", "BsmtFullBath", "BsmtHalfBath", "KitchenQual",
                     "Functional", "GarageCars", "GarageArea", "SaleType")

# Replace NA values with "None" in the specified columns
full_house[columns_with_na][is.na(full_house[columns_with_na])] <- "None"

# LotFrontage (median or regression)

full_house$LotFrontage |> median(na.rm = T)

full_house$LotFrontage |> is.na() |> sum()

# replace with median

full_house$LotFrontage[is.na(full_house$LotFrontage)] = median(full_house$LotFrontage, 
                                                               na.rm = T)

# Create model

# Separate which categorical variables will be used for training and create a formula with them

# create model (randomForest(formula = formula, data = training data, ntree = 500m mtry = 3, 
# nodesize = 0.01 * nrow(training data))

# Apply model
# Create a new formula without the class
# class = predict(model, newdata = test data)

full_house$GarageYrBlt|> median(na.rm = T)

full_house$GarageYrBlt |> is.na() |> sum() # Many rows, better regression

# replace with median

full_house$GarageYrBlt[is.na(full_house$GarageYrBlt)] = median(full_house$GarageYrBlt, 
                                                               na.rm = T)

# MasVnrArea (Median or regression)

full_house$MasVnrArea|> mean(na.rm = T)

full_house$MasVnrArea|> is.na() |> sum() # Many rows, better regression

# replace with mean

full_house$MasVnrArea[is.na(full_house$MasVnrArea)] = mean(full_house$MasVnrArea, na.rm = T)

# Convert variables to Factors

convert_to_factor_and_numeric = function(data, factor_vars, numeric_vars) {
  # Convert factor variables to factor
  for (var in factor_vars) {
    if (var %in% names(data)) {
      data[[var]] <- as.factor(data[[var]])
    } else {
      warning(paste("Variable", var, "not found in dataframe."))
    }
  }
  
  # Convert numeric variables to numeric
  for (var in numeric_vars) {
    if (var %in% names(data)) {
      data[[var]] <- as.numeric(data[[var]])
    } else {
      warning(paste("Variable", var, "not found in dataframe."))
    }
  }
  
  return(data)
}

# Define factor variables
factor_vars <- c('MSZoning', 'Street', 'LotShape', 'LandContour', 'Utilities', 'Alley', 'LotShape', 'LandContour', 'Utilities', 'LotConfig', 'LandSlope', 'Neighborhood', 'Condition1', 'Condition2', 'BldgType', 'HouseStyle', 'RoofStyle', 'RoofMatl', 'Exterior1st', 'Exterior2nd', 'MasVnrType', 'ExterQual', 'ExterCond', 'Foundation', 'BsmtQual', 'BsmtCond', 'BsmtExposure', 'BsmtFinType1', 'BsmtFinType2', 'Heating', 'HeatingQC', 'CentralAir', 'Electrical', 'KitchenQual', 'Functional', 'FireplaceQu', 'GarageType', 'GarageFinish', 'GarageQual', 'GarageCond', 'PavedDrive', 'PoolQC', 'Fence', 'MiscFeature', 'SaleType', 'SaleCondition')

# Define numeric variables
numeric_vars <- setdiff(names(full_house), factor_vars)

# Convert variables
full_house <- convert_to_factor_and_numeric(full_house, factor_vars, numeric_vars)

# Approximate data to a normal distribution

hist(full_house$SalePrice)

Column_classes <- sapply(names(full_house), function(x) {class(full_house[[x]])})
numeric_columns <- names(Column_classes[Column_classes != "factor"])

# Determine skew of each numeric variable
skew <- sapply(numeric_columns, function(x) {skewness(full_house[[x]], na.rm = TRUE)})

# Let us determine a threshold skewness and transform all variables above the threshold.
skew <- skew[skew > 0.75]

# Transform excessively skewed features with log(x + 1)
for (x in names(skew)) {
  full_house[[x]] <- log(full_house[[x]] + 1)
}

hist(full_house$SalePrice)

# Separate data for training and testing

train_house = full_house[full_house$IsTrain == T,]
test_house = full_house[full_house$IsTrain == F,]



train_house |> is.na() |> table()

# Find the row and column index of the NA value in test_house
na_index <- which(is.na(train_house), arr.ind = TRUE)

# Print the row and column index of the NA value
print(na_index)

train_house[, 43]

is.na(train_house) |> sum()

test_house |> is.na() |> sum()


train_house$IsTrain = NULL
test_house$IsTrain = NULL

# Create model with randomForest (randomForest(formula = formula, data = train, 
# ntree = 500, mtry = 3, nodesize = 0.01 * nrow(train)))

formula = as.formula("SalePrice ~ .")

house_model = randomForest(formula = formula, data = train_house, ntree = 500, mtry = 3, 
  nodesize = 0.01 * nrow(train_house))

# Make predictions with the model (predict(model, newdata = test))


result = predict(house_model, newdata = test_house)

result |> is.na() |> sum()

result = as.data.frame(result)

result$Id = test_house$Id

result$result = result$SalePrice

result$SalePrice |> median(na.rm = T)

result$SalePrice[is.na(result$SalePrice)] = median(result$SalePrice, na.rm = T)

str(result)

View(result)

# Data visualization (ggplot2)

# Export the result (write.csv(result, file = title, row.names = F))

write.csv(result, file = "submissionhouse.csv", row.names = FALSE)


