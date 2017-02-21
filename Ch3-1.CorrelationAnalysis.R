# 다변량분석
# 피어슨의 상관계수 = 두 변수간의 선형관계
# 스피어만의 상관계수 = 두 변수간의 선형관계 이외

install.packages("Hmisc")
library(Hmisc)
data(mtcars)
head(mtcars)

# disp ~ drat 간 산점도 
drat <- mtcars$drat
disp <- mtcars$disp
plot(drat,disp)

cov(drat,disp)
cor(drat,disp)

# Hmisc 패키지에 rcorr은 상관분석
# 피어슨 상관계수
rcorr(as.matrix(mtcars), type = "pearson")
cov(mtcars)

# 스피어만 상관계수
rcorr(as.matrix(mtcars), type = "spearman")

