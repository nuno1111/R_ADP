# Ch8. 그래픽 기능

# 1. 산점도 그래프
height = c(170,168,174,175,188,165,165,190,173,168,159,170,184,155,165)
weight = c(68,65,74,77,92,63,67,95,72,69,60,69,73,56,55)

plot(height,weight)

# 2. 산점도 행렬
pairs( iris[1:4], main="Anderson's Iris Data -- 3 species",
       pch = 21, bg=c("red","green3","blue")[unclass(iris$Species)])


pairs(~ Fertility + Education + Catholic, data = swiss,
      subset = Education < 20, main = "Swiss data, Education < 20")

pairs(USJudgeRatings, text.panel = NULL, upper.panel = NULL)

# 3. 히스토그램과 상자그림
StatScore = c( 88,90,78,84,76,68,50,48,33,70,48,66,88,96,79,65,27,88,96,33,64,48,77,18,26,44,48,68,77,64,88,95,79,88,49,30,29,10,49,88)
hist( StatScore, prob=T)
boxplot( StatScore)

