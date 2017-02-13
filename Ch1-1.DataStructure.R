# Ch1. 데이터 구조
# 1. Vector

x = c(1, 10, 24, 40)
y = c("사과","바나나","오렌지")
z = c(TRUE, FALSE, TRUE)

# 위와 동일한 결과 '=' 와 '<-' 동일
x <- c(1, 10, 24, 40)
y <- c("사과","바나나","오렌지")
z <- c(TRUE, FALSE, TRUE)

# 벡터 결합
xy <- c(x,y)
xy

# 2. Matrix

mx = matrix( c(1,2,3,4,5,6), ncol=2  )

r1=c(10,10)
c1=c(20,20,20)

# rbind : 행추가 
rbind(mx,r1)

# cbind : 열추가
cbind(mx,c1)

# 3. 데이터프레임 : RDB의 테이블

income = c(100,200,150,300,900)
car = c("kia","hyundai","kia","toyota","lexus")
marriage = c(FALSE,FALSE,FALSE,TRUE,TRUE)
mydat = data.frame(income,car,marriage)











