# 주성분 분석

# 미국 범죄 주성분 분석
library(datasets)
data(USArrests)

summary(USArrests)

fit <- princomp(USArrests, cor = TRUE)

summary(fit)
loadings(fit)

plot(fit, type="lines") # Scree Plot : 주성분의 분산의 크기를 그림으로..
fit

USArrests

fit$scores
biplot(fit)

# 새로운 컴퓨터 만족도 조사
Price <- c(6,7,6,5,7,6,5,6,3,1,2,5,2,3,1,2)
Software <- c(5,3,4,7,7,4,7,5,5,3,6,7,4,5,6,3)
Aesthestics <- c(3,2,4,1,5,2,2,4,6,7,6,7,5,6,5,7)
Brand <- c(4,2,5,3,5,3,1,4,7,5,7,6,6,5,5,7)
data <- data.frame(Price, Software, Aesthestics, Brand)
pca <- princomp(data, cor = T)
summary(pca, loadings = T) # Comp1은 패션추구형, Comp2는 기능 추구형

biplot(pca)










