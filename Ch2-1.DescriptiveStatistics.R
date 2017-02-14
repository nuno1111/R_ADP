# 기술적 통계를 통한 데이터 인사이트 확보

data(iris)
head(iris)
summary(iris) # 전반적 기초 통계량

mean(iris$Sepal.Length) # 특정컬럼 평균
median(iris$Sepal.Length) # 특정컬럼 중앙값
var(iris$Sepal.Length) # 특정컬럼 분산
sd(iris$Sepal.Length) # 특정컬럼 표준편차
quantile(iris$Sepal.Length) # 특정컬럼 사분위수
quantile(iris$Sepal.Length,1/4) # 특정컬럼 1사분위수
quantile(iris$Sepal.Length,3/4) # 특정컬럼 3사분위수
max(iris$Sepal.Length) # 특정컬럼 최대값
min(iris$Sepal.Length) # 특정컬럼 최소값

install.packages("MASS")
library(MASS)
data(Animals)
head(Animals)
summary(Animals)








