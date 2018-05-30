# 회귀분석 (Regression Analysis)

# 1. 모형이 통계적으로 유의미한가?
#  : F 통계량 확인, 유의수준 5% 하에서 F통계랑의 p-값이 0.05작으면 유의미

# 2. 회귀계수들이 유의미한가?
#  : 해당 계수의 t통계량과 p-값 또는 이들의 신뢰구간을 확인

# 3. 모형이 얼마나 설명력을 갖는가?
#  : 결정계수를 확인. 결정계수는 0~1. 높은값을 가질수록 회귀식의 설명력 높음
.
# 4. 모형이 데이터를 잘 적합하고 있는가?
#  : 잔차를 그래프로 그리고 회귀진단

# 5. 데이터가 아래의 모형 가정을 만족시키는가
#  - 선형성 : 독립변수의 변화에 따라 종속변수도 일정크기로 변화
#  - 독립성 : 잔차와 독립변수의 값이 관련 있지 않음
#  - 등분산성 : 독립변수의 모든 값에 대해 오차들의 분산이 일정
#  - 비상관성 : 관측치들의 잔차들끼리 상관이 없어야 함
#  - 정상성 : 잔차는 정규분포를 이뤄야함

# 단순회귀분석
set.seed(2)
x = runif(10,0,11)

y = 2 + 3 * x + rnorm(10,0,0.2)
y

dfrm=data.frame(x,y)
dfrm
plot(dfrm)

lm_1 <- lm(y~x, data = dfrm)
summary(lm_1)
plot(lm_1)

# 다중회귀분석
set.seed(2)

u=runif(10,0,11)
v=runif(10,11,20)
w=runif(10,1,30)

y=3 + 0.1*u + 2*v - 3*w + rnorm(10,0,0.1)

dfrm=data.frame(y,u,v,w)
dfrm

m <- lm(y ~ u + v + w)
m

plot(m)
summary(m) # p 값이 0.05이하이므로 유의미, 결정계수도 1이므로 유의

# 식이요법 방법 적용한 닭 데이터 / 단순회귀분석
# install.packages("MASS")
library(MASS)
head(ChickWeight)
summary(ChickWeight)
class(ChickWeight)

Chick <- ChickWeight[ChickWeight$Chick==1,]
Chick
plot(Chick)

ChickLM<-lm(weight~Time, data=Chick)
summary(ChickLM)
plot(Chick$Time,Chick$weight)
plot(ChickLM)

Chick$Time2 <- Chick$Time ^ 2
ChickLM2<-lm(weight~Time2 + Time, data=Chick)
summary(ChickLM2)
plot(ChickLM2)

# CARS 데이터를 활용한 다항회귀분석
data(cars)
head(cars)

plot(cars)

speed2 <- cars$speed^2

cars <- cbind(speed2,cars)
head(cars)

lm(dist~speed + speed2, data = cars)
summary(lm(dist~speed + speed2, data = cars))

# 아래 x, y 데이터의 적합한 회귀모형 찾기
x <- c(1,2,3,4,5,6,7,8,9)
y <- c(5,3,2,3,4,6,10,12,18)
dfxy <- data.frame(x,y)
dfxy

# 1. y = ax + b 의 선형(단순)회귀
dfxy1lm <- lm(y~x,data = dfxy)
summary(dfxy1lm) # p-value = 0.004446

# 2. y = ax + bx^2 + c 의 다중회귀
x2 <- x^2
dfxy2 <- cbind(dfxy,x2)
dfxy2

dfxy2lm <- lm(y~x + x2, data = dfxy2)
summary(dfxy2lm) # p-value = 1.05e-06

# 따라서 2차 다중회귀 모형이 더 적합

plot(dfxy1lm)
plot(dfxy2lm)

# 후진제거법을 통한 변수 선택
X1 <- c(7,1,11,11,7,11,3,1,2,21,1,11,10)
X2 <- c(26,29,56,31,52,55,71,31,54,47,40,66,68)
X3 <- c(6,15,8,8,6,9,17,22,18,4,23,9,8)
X4 <- c(60,52,20,47,33,22,6,44,22,26,34,12,12)
Y <- c(78.5,74.3,104.3,87.6,95.9,109.2,102.7,72.5,93.1,115.9,83.8,113.3,109.4)

df <- data.frame(X1,X2,X3,X4,Y)
plot(df)

a <- lm(Y~X1+X2+X3+X4,data = df)
a
summary(a) # X3의 유의 확률이 가장높아 가장 유의하지 않으므로 변수제거후 재실행

b <- lm(Y~X1+X2+X4,data = df)
b
summary(b) # X3 제외 X4 유의 확률이 가장높아 가장 유의하지 않으므로 변수제거후 재실행

c <- lm(Y~X1+X2,data = df)
c
summary(c) # X1,X2 p값도 유의하므로 여기서 중단

# 자동으로 전진/후진/단계적 제거법 수행
step( lm(Y ~1, df), scope=list(lower=~1, upper=~X1+X2+X3+X4), direction = "forward") # 전진

step( lm(Y ~1, df), scope=list(lower=~1, upper=~X1+X2+X3+X4), direction = "both") # 단계적

# MASS패키지의 hills 데이터 step합수를 이용해 전진선택법 회귀분석 수행, time이 종속변수

library(MASS)
data(hills)
head(hills)

step( lm(time ~1, hills), scope=list(lower=~1, upper=~dist+climb), direction = "forward") #전진




























