# 데이터마트
# R reshape 패키지 활용한 데이터 마트 구성
# melt / cast

install.packages("reshape")
library(reshape)

data(airquality)
airquality

head(airquality) # 데이터 일부분
head(airquality,10) # 데이터 상위 10개 데이터

names(airquality) # 변수명 확인

names(airquality) = tolower(names(airquality)) # 변수명 소문자로 변경

aqm = melt(airquality, id=c("month","day"), na.rm = TRUE)

a <- cast(aqm, day ~ month ~ variable)
a

b <- cast(aqm, month ~ variable, mean)
b

c <- cast(aqm, month ~ . | variable, mean)
c

# 행과 열 소계
d <- cast(aqm, month ~ variable, mean, margins = c("grand_row","grand_col"))
d

# 특정변수만 처리
e <- cast(aqm, day ~ month, mean, subset = variable=="ozone")
e

# range = min, max를 동시에 표시 _X1 = min, _X2 = max
f <- cast(aqm, month ~ variable, range)
f





