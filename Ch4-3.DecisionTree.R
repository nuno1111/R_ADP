# 의사결정나무분석

library(rpart)
c <- rpart(Species ~., data = iris )
c

plot(c, compress = T, margin = 0.3)
text(c, cex=1.5)

head(predict(c, newdata = iris, type = "class"))
tail(predict(c, newdata = iris, type = "class"))

# 의사결정나무 시각화
#install.packages("rpart.plot")

library(rpart.plot)
prp(c, type = 2, extra = 2)

ls(c)

# cptable 트리의 크기에 따른 비용-복잡도 모수 제공 및 교차타당성 오차 함께 제공
# prune() 또는 rpart.control() 함수에서 가지치기와 트리의 최대크기를 조정하기 위한 옵션으로 사용

c$cptable
opt <- which.min(c$cptable[,"xerror"])
opt
cp <- c$cptable[opt, "CP"]
cp
prune.c <- prune(c, cp = cp)
prune.c
plot(prune.c)
text(prune.c, use.n = T)

plotcp(c)

# 의사결정나무 2번째 예제 {party} ctree() 함수
# install.packages("party")
library(party)

data(stagec) # 146명의 전립선 암환자 자료
str(stagec) # y : ploidy

# 결측값 제거
stagec1 <- subset(stagec, !is.na(g2))
stagec2 <- subset(stagec1, !is.na(gleason))
stagec3 <- subset(stagec2, !is.na(eet))

nrow(stagec)
nrow(stagec1)
nrow(stagec2)
nrow(stagec3)

str(stagec3)

# training & test = 70% & 30%
set.seed(1234)
ind <- sample(2, nrow(stagec3), replace = TRUE, prob = c(0.7,0.3))
ind

trainData <- stagec3[ind==1,]
testData <- stagec3[ind==2,]

tree <- ctree(ploidy ~ ., data = trainData)
tree
plot(tree)

testPred = predict(tree, newdata = testData)
testPred

table(testPred, testData$ploidy)

# 의사결정트리 3번째 예제 : 반응변수가 연속변수인 airquality

airq <- subset(airquality, !is.na(Ozone)) # 오존 결측 자료 제거

head(airq)
str(airq)

airct <- ctree(Ozone ~ . , data = airq)
airct

plot(airct)

predict(airct, data = airq)

predict(airct, data = airq, type = "node") # > where(airct) 의 결과와 동일
# where(airct)

mean((airq$Ozone - predict(airct))^2) # 평균제곱오차
mean(sqrt((airq$Ozone - predict(airct))^2))












