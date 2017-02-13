# 결측값 처리와 이상값 검색

# 데이터 탐색 / 기초통계

data(iris)
head(iris)
head(iris,10)

str(iris) # 데이터 구조
summary(iris) # 데이터 기초 통계량

class(iris)
cov(iris[,1:4]) # 공분산
cor(iris[,1:4]) # 상관계수

# 결측값 처리 패키지
# Amelia II, Mice, mistools중 Amelia이용
# 결측값 = NA, 불가능한값 = NaN
y <- c(1,2,3,NA)
is.na(y)

# 특정위치 결측값 입력
# mydata[mydata$v1==99,"v1"] <- NA # 99를 결측값으로 처리

# 평균 산출 등 데이터처리시 결측값 처리
x <- c(1,2,NA,3)
mean(x)
mean(x,na.rm = T)

# 결측치가 포함된 관측치 삭제 : complete.cases()
# 결측값 많을 때 주의
# mydata[!complete.cases(mydata),]

# Amelia 이용
install.packages("Amelia")
library(Amelia)

data(freetrade)
head(freetrade)
str(freetrade)

# 년도와 국가를 고려한 결측값에 대한 imputation 진행, m= 몇개의 imputation dataset 인지
# ts = 시계열 , cs = cross-sectional
a.out <- amelia(freetrade, m = 5, ts = "year", cs = "country")
hist(a.out$imputations[[3]]$tariff, col = "grey", border = "white")
save(a.out, file = "imputations.RData")
write.amelia(obj = a.out, file.stem = "outdata")

missmap(a.out) # 결측값 처리 전후 비교

# 결측값 처리 
freetrade$tariff <- a.out$imputations[[5]]$tariff
a.out$imputations[[5]]

missmap(freetrade)

# 이상값 처리
x <- rnorm(100)
boxplot(x)

x=c(x,19,28,30)# 고의적으로 이상값 입력
outwith=boxplot(x)
outwith$out # 이상값 출력

# outliers 패키지 이용
install.packages("outliers")
library(outliers)

set.seed(1234)
y<-rnorm(100)
outlier(y) # 평균과 가자 큰 차이가 있는 값

dim(y) = c(20,5) # 20행 5열 생성
outlier(y) # 각 열의 평균과 가장 큰 차이가 있는 값

outlier(y,opposite = TRUE) # 각 열별로 반대방향으로 열평균과 가장 차이가 많은 값

boxplot(y)





