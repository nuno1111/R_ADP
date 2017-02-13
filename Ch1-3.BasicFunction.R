# Basic Function

# 1. 수열생성

rep(1,3) # 수 반복

seq(1,3) # 수열 생성
1:3 # seq(1,3) 와 동일

seq(1,11,by=2) # 2씩 증가 수열

seq(1,11,length=6) # 수열의 개수가 6
seq(1,11,length=8)

rep(2:5,3) # (2:5)수열을 (3번) 반복

# 2. 기초적인 수치계산

a <- 1:10
a
a+a
a-a
a*a
a/a

a=c(2,3,4)
a
t(a) # 전치행렬

A=a%*%t(a) # 행렬곱 (3 x 1) * (1 x 3) = (3 x 3)
A

mx = matrix(c(23,41,12,35,67,1,24,7,53),nrow = 3)
mx
5 * mx # 스칼라 곱
solve(mx) # 역행렬

# 3. 기초통계량

a <- 1:10
a
mean(a) # 평균
var(a) # 분산
sd(a) # 표준편차
sum(a) # 합
median(a) # 중간값
log(a) # 로그값

b = log(a)
cov(a,b) # 공분산
cor(a,b) # 상관계수
summary(a) # 정보요약




