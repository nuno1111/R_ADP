# Ch2-2. sqldf를 활용한 데이터 분석
# sas 유저가 사용하기 좋은 패키지

install.packages("sqldf")
library(sqldf)

data(iris)

sqldf("select * from iris")

sqldf("select * from iris limit 10")

sqldf("select count(*) from iris where Species like 'se%'")
