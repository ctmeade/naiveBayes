#Package for naiveBayes
require(e1071)

#Importing the training and test data sets, and assigning variables names
train_variables <- c("age","workclass","fnlwgt","education","education-num","marital-status","occupation","relationship","race","sex","capital-gains","capital-losses","hoursweek","native-country","income")
training <- read.table("training.txt", header = FALSE, col.names = train_variables)
test <- read.table("test.txt", header = FALSE, col.names = train_variables)
#Explore Data
summary(training)
head(training)
tail(training)
summary(test)

#Model 1
model1 <- naiveBayes(income~.,data = training)
summary(model1)
str(model1)

#Model Analyitics
model1_test_predict <- predict(model1,test[,-1])
#confusion matrix
table(pred=model1_test_predict,true=test$income)
#fraction of correct predictions
mean(model1_test_predict==test$income)

#Model 2
#Remove education-num b/c redundant, fnlwgt b/c ananlysis not advanced enough
training[["education-num"]] = NULL
training[["fnlwgt"]] = NULL
test[["education-num"]] = NULL
test[["fnlwgt"]] = NULL

model2 <- naiveBayes(income~.,data = training)
summary(model2)
str(model2)

#Model Analyitics
model2_test_predict <- predict(model2,test[,-1])
#confusion matrix
table(pred=model2_test_predict,true=test$income)
#fraction of correct predictions
mean(model2_test_predict==test$income)

#Model 3
training$workclass <- as.factor(training$workclass)
plot(training$workclass)
summary(training$workclass)
#Refining workclass
training$workclass = gsub("^Federal-gov","Gov",training$workclass)
training$workclass = gsub("^Local-gov","Gov",training$workclass)
training$workclass = gsub("^State-gov","Gov",training$workclass)
training$workclass = gsub("^Self-emp-inc","Self-emp",training$workclass)
training$workclass = gsub("^Self-emp-not-inc","Self-emp",training$workclass)
training$workclass = gsub("^Never-worked","Unemployed",training$workclass)
training$workclass = gsub("^Without-pay","Unemployed",training$workclass)

test$workclass = gsub("^Federal-gov","Gov",test$workclass)
test$workclass = gsub("^Local-gov","Gov",test$workclass)
test$workclass = gsub("^State-gov","Gov",test$workclass)
test$workclass = gsub("^Self-emp-inc","Self-emp",test$workclass)
test$workclass = gsub("^Self-emp-not-inc","Self-emp",test$workclass)
test$workclass = gsub("^Never-worked","Unemployed",test$workclass)
test$workclass = gsub("^Without-pay","Unemployed",test$workclass)

model3 <- naiveBayes(income~.,data = training)
summary(model3)
str(model3)

#Model Analyitics
model3_test_predict <- predict(model3,test[,-1])
#confusion matrix
table(pred=model3_test_predict,true=test$income)
#fraction of correct predictions
mean(model3_test_predict==test$income)

#Model 4

