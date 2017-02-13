# 데이터 테이블은 데이터 프레임과 유사 빠른 그룹화, 짧은 문장 지원
# install.packages("data.table")

library(data.table)

DT = data.table(x=c("b","b","b","a","a"),v=rnorm(5)) # rnorm(5) : 정규분포에서 5개 난수 생성
DT

data(cars)
head(cars)

CARS = data.table(cars) # 데이터 프레임을 데이터 테이블로 변환
head(CARS)

tables() # 현재 테이블 정보 확인

sapply(CARS,class) # 각 컬럼의 데이터 타입확인
sapply(DT,class) # 각 컬럼의 데이터 타입확인

DT[2,] # 2행값 조회
DT[DT$x=="b",] # x값이 'b'인것 만 조회

# DT에 key값 지정 -> ordering 실행
setkey(DT,x)
DT
tables()

DT["b",] # x값이 'b'인것 만 조회
DT["b",mult="first"] # x값이 'b' 인것 중에 첫번째 것
DT["b",mult="last"] # x값이 'b' 인것 중에 마지막 것

# 대용량에서 비교
grpsize <- ceiling(1e7/26^2) # 천만개의 행과 676개 그룹
tt <- system.time(
  DF <- data.frame(
    x=rep(LETTERS,each=26*grpsize),
    y=rep(letters,each=grpsize),
    v=runif(grpsize*26^2),
    stringAsFactors = FALSE
  )
)
tt

head(DF,3) # 앞 3줄 조회
tail(DF,3) # 뒤 3줄 조회

dim(DF) # 행,열 개수 조회

ttt <- system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",])
ttt # 1.594초 DF는 Full Scan 방식

head(ans1)
dim(ans1)

DT <- data.table(DF)
setkey(DT,x,y) # key적용은 RDB에 index적용과 동일
ss <- system.time(ans2 <- DT[J("R","h")])
ss # index 적용으로 0.002 초

head(ans2)
dim(ans2)

identical(ans1$v,ans2$v) # 데이터 비교 함수

# 데이터 테이블을 데이터 프레임처럼 쓰면 속도는 여전히 느림
system.time(ans3 <- DT[DT$x=="R" & DT$y=="h",])  # 1초
mapply(identical, ans1, ans3) # 각 컬럼마다 indentical 함수 적용

# DT 다른 기능 
# DT[i,j,by] => i는 where조건, j는 원하는 값, by 는 groupBy 
DT[,sum(v)]
DT[,sum(v),by=x]

tttt <- system.time( ta <- tapply(DT$v, DT$x,sum)); tttt # 1억건 8.6초
# tapply(X,INDEX, FUN = NULL, ..., simplify = TRUE) 
# INDEX기준으로 X값에 대해 FUN 합수 적용

ssss <- system.time( sa <- DT[,sum(v),by=x]); ssss # 1억건 5.9초

head(ta)
head(sa)

# summary 또는 grouping
# select x,y,sum(v) from DT group by x, y
uuu <- system.time( uu <- DT[,sum(v), by="x,y"]);uuu;uu












