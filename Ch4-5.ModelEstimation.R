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




