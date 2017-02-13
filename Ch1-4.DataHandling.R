# Ch 4. R 데이터 핸들링

# 1. 벡터데이터 핸들링
b=c("a","b","c","d","e")

b[2] # 2번째 원소값
b[-4] # 4번째 원소를 제외한 값
b[c(2,3)] # 2,3 번째값

# 2. 행령/데이터 프레임 핸들링

income = c(100,200,150,300,900)
car = c("kia","hyundai","kia","toyota","lexus")
marriage = c(FALSE,FALSE,FALSE,TRUE,TRUE)
mydat = data.frame(income,car,marriage)

mydat[3,2] # 3행 2열

mydat[,2] # 2열

mydat[4,] # 4행
