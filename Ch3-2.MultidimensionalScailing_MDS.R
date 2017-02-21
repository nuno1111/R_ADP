# 다차원 척도법
# 여러 대상 간의 거리가 주어져 있을때 대상들을 
# 동일한 상대적 거리를 가진 실수공간의 점들로 배치시키는 방법

# 자료들의 상대적 관계를 이해하는 시각화 방법

data(eurodist)
eurodist

loc <- cmdscale(eurodist)
loc

x <- loc[,1]
y <- loc[,2]

plot(x,y,type = "n", main = "eurodist") # 우선 그래프를 안그리고
text(x,y,rownames(loc),cex = 0.8) # 그래프에 텍스트를 입힌다.
abline(v=0,h=0) # x,y축을 입힌다.


















