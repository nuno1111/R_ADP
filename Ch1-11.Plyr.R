# Plyr : 데이터를 분리하고 처리 후 다시 결합 가장 필수적인 데이터 처리기능 제공

set.seed(1) # 일정한 난수 

# year : 2012 ~ 2014 까지 6개씩 18개 데이터 
# count : 0 ~ 20 사이 9개 난수 (runif로 난수생성)
d = data.frame( year = rep(2012:2014, each = 6), count = round(runif(9,0,20)) )
d

library(plyr)


# cv (변동계수 : coefficient of variation) = sd(표준편차) / mean(평균)
ddply(d, "year", function(x){
  mean.count = mean(x$count)
  sd.count = sd(x$count) 
  cv = sd.count / mean.count
  data.frame(cv.count = cv)
})

ddply(d, "year", summarise, mean.count = mean(count)) # summarise : agg 된 결과값만 저장 
ddply(d, "year", transform, total.count = sum(count)) # transform : agg 된 결과값을 기존변수에 추가 

