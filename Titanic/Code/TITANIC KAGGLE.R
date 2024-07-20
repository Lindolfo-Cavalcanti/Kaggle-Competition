## TITANIC KAGGLE

library(tidyverse)
library(randomForest)

# Passo a passo titanic 

# 1- Carregar dados corretamente (stringsAsFactors = F)

train_data = read.csv("/home/lindo/Documents/Kaggle/TitanicKaggle/train.csv",
stringsAsFactors = F)

test_data = read.csv("/home/lindo/Documents/Kaggle/TitanicKaggle/test.csv", 
stringsAsFactors = F)

# 2- Tratar dados
	
	# Igualar colunas

    str(c(train_data, test_data))    

    test_data$Survived = NA

    head(test_data)

	# Juntar tabelas (rbind())

     train_data$IsTrain = T

      test_data$IsTrain = F

     head(train_data$IsTrain)
     head(test_data$IsTrain)

     full_data = rbind(train_data, test_data)

     glimpse(full_data)

	# Valores NA (sem excluir linhas)
        
        table(is.na(full_data)) #682

        table(is.na(full_data$Age)) #263
        table(is.na(full_data$Fare)) #1
        table(is.na(full_data$Survived)) #418

        AgeMedian = median(full_data$Age, na.rm = T)

        full_data = full_data |> 
            mutate(Age = ifelse(is.na(Age), AgeMedian, Age))

        FareMedian = median(full_data$Fare, na.rm = T)

        full_data = full_data |> 
            mutate(Fare = ifelse(is.na(Fare), FareMedian, Fare))
        
	# Ajeitar categorias (Pclass, Sex, Embarked)
        
        str(full_data)
        
        full_data$Pclass = as.factor(full_data$Pclass)
        full_data$Sex = as.factor(full_data$Sex)
        full_data$Embarked = as.factor(full_data$Embarked)
        
	# Separar tabelas
        
      train_data_tratado = full_data %>% 
        filter(full_data$IsTrain == T)
      
      glimpse(train_data_tratado)
      table(is.na(train_data_tratado))
      
      train_data_tratado$IsTrain = NULL
      
      test_data_tratado = full_data %>% 
        filter(full_data$IsTrain == F)
      
      glimpse(test_data_tratado)
      table(is.na(test_data_tratado))
      
      test_data_tratado$IsTrain = NULL
      
	# Ajeitar categoria de Survived da tabela de treinamento
      
      train_data_tratado$Survived = as.factor(train_data_tratado$Survived)
	
# 3 - Criar modelo
	
	# Separar quais categorias vão ser usadas para o treinamento e criar uma formula com elas
      
      survived_solution = "Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
      survived_formula = as.formula(survived_solution)
      
	# criar modelo (randomForest(formula = formula, data = treino, ntree = 500, mtry = 3, 
  #nodesize = 0.01 * nrow(treino))
      
      model = randomForest(formula = survived_formula, data = train_data_tratado, ntree = 500, mtry = 3,
                   nodesize = 0.01 * nrow(train_data_tratado))
	
# 4 - Aplicar modelo

	# Criar uma nova formula sem o Survived
      
      features_solution = "Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
      
	# Survived = prever (predict(modelo, newdata = teste))
  
     solution_titanic = predict(model, newdata = test_data_tratado)
     table(solution_titanic)

# 5 - Criar o output
	# Criar um dataframe (as.data.frame) com o ID e Survived
     
     PassengerId = test_data_tratado$PassengerId
     output = as.data.frame(PassengerId)
     output$Survived = solution_titanic
     
     table(output)
     
	# exportar: write.csv(resultado, file = titulo. row.names = F)
     
     write.csv(output, file = "titanic_submission2.csv", row.names = F)
