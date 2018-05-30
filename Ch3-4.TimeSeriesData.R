# 시계열 예측
# 시계열의 정상성

# 1. 평균이 일정하다
# 2. 분산이 시점에 의존하지 않는다
# 3. 공분산은 단지 시차에만 의존하고 시점 자체에는 의존하지 않는다.

# 백색잡음 (At) : 독립이고 같은 분포를 따르며 평균이 0이고 분산이 시그마^2 인 확률변수 (대표적 정상 시계열)

# ARIMA 분석
# 1. 자귀회귀모형(AR) : 현 시점 자료가 P시점 전의 유한개의 과거자료로 설명
# 2. 이동평균모형(MA) : 현 시점 자료는 유한개의 백색잡음의 선형 결합
# 3. 자기회귀누적이동평균모형(ARIMA) : ARIMA(p,d,q) 
#    p = AR, d = I , q = MA
#    d = 정상화했을때 차분의 수
#    p = 0 => IMA(d,q)
#    d = 0 => ARMA(p,q)
#    p = 0 => ARI(p,d)

# 분해시계열
# 1. 추세요인
# 2. 계절요인
# 3. 순환요인
# 4. 불규칙요인

Nile # 아스완 댐 나일강 연간 유입량 시계열 데이터

ldeaths # 1974 ~ 1979 영국내 월별 폐질환 사망자

mdeaths # 1974 ~ 1979 영국내 월별 폐질환 남자 사망자

fdeaths # 1974 ~ 1979 영국내 월별 폐질환 여자 사망자

plot(Nile) # 평균이 고르지 못해 비정상성

plot(ldeaths) # 년도별 계절성 존재

# 분해 시계열
ldeaths.decompose <- decompose(ldeaths)
ldeaths.decompose$seasonal 

plot(ldeaths.decompose)

# 원자료에서 시계열 자료를 삭제
ldeaths.decompose.adj <- ldeaths - ldeaths.decompose$seasonal 
plot(ldeaths.decompose.adj)


# ARIMA 모형
# A.차분
# A-1. 1번 차분
Nile.diff1 <- diff(Nile, differences = 1)
plot(Nile.diff1)

# A-2. 2번 차분
Nile.diff2 <- diff(Nile, differences = 2)
plot(Nile.diff2)

# B.ARIMA 모델 적합 및 결정

# B-1. 자기상관함수
acf(Nile.diff2, lag.max=20)
acf(Nile.diff2, lag.max=20, plot = FALSE)

# B-2. 부분 자기상관함수
pacf(Nile.diff2, lag.max=20)
pacf(Nile.diff2, lag.max=20, plot = FALSE)

# ARIMA 모형 선택은 어려워... 그래서... forecast 패키지에 auto.arima로 모형결정
# install.packages("forecast")
library(forecast)

auto.arima(Nile) # auto.arima로 적절한 모형은 ARIMA(1,1,1) 으로 결정

Nile.arima <- arima(Nile, order=c(1,1,1))
Nile.arima

# 향후 10년 예측
Nile.forecasts <- forecast( Nile.arima, h=10 )
Nile.forecasts

plot(Nile.forecasts)

















