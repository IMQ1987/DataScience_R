#https://www.datacamp.com/community/tutorials/machine-learning-in-r#sets
library(caret)
library(ggplot2)

ggplot(iris, aes(x=Petal.Length,
                 y=Petal.Width,
                 color=Species)) + geom_point() + geom_smooth()

# unterstütze Algorithmen
names(getModelInfo())

names(iris.training)

#index <- numeric(dim(iris)[1])
#index <- sample(length(index),c(1,length(index)), prob = 0.67)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67,0.33))
iris.training <- iris[ind==1, 1:4]
iris.training <- cbind(iris.training, iris[ind==1, 5])

colnames(iris.training[5]) = colnames(iris[5])
iris.test <- iris[ind==2, 1:4]
iris.test <- cbind(iris.test, iris[ind==2, 5])

iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)


model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn')
predictions<-predict(object=model_knn,iris.test[,1:4])
table(predictions)
confusionMatrix(predictions,iris.test[,5])
