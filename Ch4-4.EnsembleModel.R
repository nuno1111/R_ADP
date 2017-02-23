# 앙상블 모형

# 1. bagging(bootstrap aggregating) : 원 데이터 집합에서 크기가 같은 표본을 여러번 단순 임의 복원 추출 , 각 표본에 대해 분류기 생성 후 그 결과 앙상블

# install.packages("adabag") # Applies Multiclass AdaBoost.M1, SAMME and Bagging
library(adabag)

data(iris)

iris.bagging <- bagging(Species~., data = iris, mfinal = 10)
iris.bagging

iris.bagging$importance

plot(iris.bagging$trees[[10]])
text(iris.bagging$trees[[10]])

# 예측
pred <- predict(iris.bagging, newdata=iris)
table(pred$class, iris[,5])

# 2. boosting : bagging과 유사하나 분류가 잘못된 데이터에 더 큰 가중을 주어 표본을 추출
# AdaBoosting(adaptive boosting) : 가장 많이 사용되는 부스팅 알고리즘

boo.adabag <- boosting(Species~., data = iris, boos = TRUE, mfinal = 10)
boo.adabag$importance

plot(boo.adabag$trees[[10]])
text(boo.adabag$trees[[10]])

# 예측
pred <- predict(boo.adabag, newdata=iris)
tb <- table(pred$class, iris[,5])
tb

# 오류율
error.rpart <- 1 - ( sum(diag(tb)) / sum(tb) )
error.rpart

# ada 
# install.packages("ada") # The R Package Ada for Stochastic Boosting
library(rpart)
library(ada)
data(iris)

iris[iris$Species != "setosa", ] -> iris
n <- dim(iris[1])[1]
n

# 100개자료를 훈련/검증 자료 6:4 로 split
trind <- sample(1:n, floor(.6*n), FALSE)
teind <- setdiff(1:n, trind)

iris[,5] <- as.factor((levels(iris[,5])[2:3]))[as.numeric(iris[,5])-1]


gdis <- ada(Species~., data=iris[trind,], iter=20, nu=1, type="discrete") # Fitting Stochastic Boosting Models
gdis <- addtest(gdis, iris[teind, -5], iris[teind, 5]) # Add a test set to ada
gdis

plot(gdis, TRUE, TRUE)
varplot(gdis) # 변수의 중요도
pairs(gdis, iris[trind,-5], maxvar = 4)

# 3. 랜덤 포레스트
#install.packages("randomForest")
library(randomForest)
library(rpart)

data(stagec)

statgec3 <- stagec[complete.cases(stagec),] # complete.cases 데이터가 모두 정상값

set.seed(1234)
ind <- sample(2, nrow(statgec3), replace = TRUE, prob = c(0.7,0.3))

trainData <- statgec3[ind==1,]
testData <- statgec3[ind==2,]

rf <- randomForest(ploidy ~ ., data = trainData, ntree=100, proximity=TRUE)
table(predict(rf), trainData$ploidy)

print(rf)
plot(rf)
importance(rf) # 변수별 중요성
varImpPlot(rf) # 변수의 중요도 그림 / 해당 변수로 분할이 일어날때 불순도의 감소가 얼마나 일어나는지 나타냄

# 예측 수행
rf.pred <- predict(rf, newdata = testData)
table(rf.pred, testData$ploidy)

plot(margin(rf))

# RandomForest 다른 패키지 {party} cforest()
library(party)
set.seed(1234)
cf <- cforest(ploidy ~ ., data = trainData)
cf.pred <- predict(cf, newdata = testData, OOB = TRUE, type="response")

table(cf.pred, testData$ploidy)


































