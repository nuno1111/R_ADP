# 모형평가

# 1. sample 함수를 통한 holdout수행
data("iris")
nrow(iris)

set.seed(1234)
idx <- sample(2,nrow(iris), replace = TRUE, prob = c(0.7,0.3))
traindata <- iris[idx==1,]
testdata <- iris[idx==2,]

nrow(traindata)
nrow(testdata)
# rm(list = ls())

# 2. k-fold 교차 검증 : 사이즈가 동일한 k개의 하부집합으로 나누고 k번의 검증수행후 평균 계산

data(iris)
set.seed(1234)
k=10 # 10-fold cross validation

iris <- iris[sample(nrow(iris)),] # Randomly, shuffle the data
folds <- cut(seq(1,nrow(iris)), breaks = k, labels = FALSE)
trainData = list(0) # an empty list of length k
testData = list(0)
for( i in 1:k ){ # Perform 10 fold cross validation
  testIdx <- which(folds==i, arr.ind=TRUE)
  testData[[i]] <- iris[testIdx,]
  trainData[[i]] <- iris[-testIdx,]
}
head(trainData[[1]])
str(trainData)
head(testData[[2]])
str(testData)

# 3. 붓스트랩 : 평가를 반복한다는 측면에서 교차검증과 유사
#              훈련용 자료를 반복 재선정 한다는 점에서 차이
#              복원 추출법으로 훈련용 자료 사용

# 예제 3. 오분류표를 통한 신경망 모형, 의사결정나무 모형 비교평가
# rm(list = ls())
iris <- subset(iris, Species == "setosa" | Species == "versicolor")
iris$Species <- factor(iris$Species)
set.seed(1234)
iris <- iris[sample(nrow(iris)),] # Randomly shuffle the data
trainData <- iris[1:(nrow(iris)*0.7)  ,]
testData <- iris[((nrow(iris)*0.7)+1):nrow(iris),]

nrow(trainData)
nrow(testData)

library(nnet)
library(rpart)

nn.iris <- nnet(Species ~ ., data = trainData, size = 2, rang = 0.1, decay=5e-4, maxit=200  ) # Neural network

dt.iris <- rpart(Species~., data = trainData) # Decision Tree

# 예측값 도출
nn_pred <- predict(nn.iris, testData, type = "class")
dt_pred <- predict(dt.iris, testData, type = "class")

# 각 모형의 오분류를 도출하기 위하여  {caret} confusionMatrix() 함수 이용
# install.packages("e1071")

library(caret)
nn_con = confusionMatrix(nn_pred, testData$Species)
dt_con = confusionMatrix(dt_pred, testData$Species)

nn_con$table
dt_con$table

accuracy <- c(nn_con$overall['Accuracy'], dt_con$overall['Accuracy'])
precision <- c(nn_con$byClass['Pos Pred Value'], dt_con$byClass['Pos Pred Value'])
recall <- c(nn_con$byClass['Sensitivity'], dt_con$byClass['Sensitivity'])
f1 <- 2 * ((precision * recall) / (precision + recall))
result <- data.frame(rbind(accuracy,precision,recall,f1))
names(result) <- c("Nueral Network", "Decision Tree")
result

## ROC 그래프 : Receiver Operating Characteristic : 레이더 이미지 분석의 성과 측정을 위해 개발
# 두 분류 분석 모형을 비교 분석 결과를 가시화 가능

# 예제4 infert 자료에 대한 분류 분석 모형 평가 비교 / 의사결정나무 vs 신경망 모형
# 의사결정나무 모형 R 패키지 {C50} C5.0()
# 신경망 모형은 {neuralnet} neuralnet()

set.seed(1234)
data(infert)
infert <- infert[sample(nrow(infert)),] # Randomly Shuffle the data
infert <- infert[,c("age","parity","induced","spontaneous","case")]

trainData <- infert[1:(nrow(infert))*0.7,]
testData <- infert[((nrow(infert))*0.7+1):nrow(infert),]

# 각 모형을 학습 -> 검증 -> 예측값 -> ROC 그래프 작성
library(neuralnet) # neural network
net.infert <- neuralnet( case ~ age + parity + induced + spontaneous, data = trainData, hidden = 3, err.fct = "ce",linear.output = FALSE, likelihood = TRUE)
net.infert

n_test <- subset(testData, select =-case)
nn_pred <- compute(net.infert, n_test)

testData$net_pred <- nn_pred$net.result

head(testData)

# install.packages("C50")
library(C50)
trainData$case <- factor(trainData$case)
dt.infert <- C5.0(case ~ age + parity + induced + spontaneous, data = trainData )
testData$dt_pred <- predict(dt.infert, testData, type="prob")[,2]
head(testData)


# ROC 그래프를 그리기 위한 {Epi} R 패키지 ROC() 함수
# install.packages("Epi")
library(Epi)
neural_ROC <- ROC(form = case ~ net_pred, data=testData, plot="ROC")

dtree_ROC <- ROC(form = case ~ dt_pred, data=testData, plot="ROC")

### 이익 도표와 향상도 곡선
# 이익  도표 : 목표 범주에 속하는 개체들이 각 등급에 얼마나 분포하고 있는지를 나타내는 값
#              해당 등급에 따라 계산된 이익값을 누적으로 연결한 도표
# 향상도곡선 : 랜덤모델과 비교하여 해당 모델의 성과가 얼마나 향상되었는지를 각 등급별로 파악하는 그래프

# install.packages("ROCR")
library(ROCR)              

n_r <- prediction(testData$net_pred, testData$case)
d_r <- prediction(testData$dt_pred, testData$case)
n_p <- performance(n_r, "tpr","fpr") # ROC graph for neural network
d_p <- performance(d_r, "tpr","fpr") # ROC graph for decision tree

plot(n_p, col="red") # neural network (RED)
par(new=TRUE)
plot(d_p, col="blue") # decision tree (Blue)
abline(a=0, b=1) # random model graph(Black)

# 향상도 곡선
n_lift <- performance(n_r, "lift", "rpp")
plot(n_lift, col="red")
abline(v=0.2) # black line








