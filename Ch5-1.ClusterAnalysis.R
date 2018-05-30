# 군집 분석

# 1. 계층적 군집
# 병합적 방법 & 분할적 방법
# 병합적 방법 : hclust {stats}, {cluster}패키지의 agnes(), mclust() 함수
# 분할적 방법 : {cluster} 패키지 diana(), mona()

# 예제 1. hclust 계층적 군집
# dist() - 거리
# hclust() - 군집

data(USArrests)
str(USArrests)


d <- dist(USArrests, method = "euclidean")
d
fit <- hclust(d, method = "ave")
fit

par(mfrow=c(1,2))
plot(fit)
plot(fit,hang=-1) # 덴드로 그램
par(mfrow=c(1,1))

# cutree() tree의 높이나 그룹의 수를 옵션으로 지정
groups <- cutree(fit, k=6)
groups

# rect.hclust() : 덴드로그램에 그룹화 보여주기
plot(fit)
rect.hclust(fit, k=6, border = "red")

hca <- hclust(dist(USArrests))
plot(hca)
rect.hclust(hca, k = 3, border = "red")
rect.hclust(hca, h = 50, which = c(2,7), border = 3:4)

# agnes() : 계층적 군집방법 중 병합적 방법
# daisy() : 범주형도 관측치 사이 거리 계산 해주는 함수

library(cluster)
agn1 <- agnes(USArrests, metric = "menhattan", stand=TRUE)
agn1
par(mfrow=c(1,2))
plot(agn1)

agn2 <- agnes(daisy(USArrests), diss=TRUE, method = "complete")
plot(agn2)

agn3 <- agnes(USArrests, method = "flexible", par.meth=0.6)
plot(agn3)

par(mfrow=c(1,1))

# kmeans

# 군집수에 따른 제곱합 그래프용 함수
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1) * sum(apply(data,2,var))
  for( i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data,centers = i)$withinss)
  }
  plot(1:nc, wss, type = "b", xlab = "Number of Clusters", ylab="Within groups sum of squares")
}

# 예제1.178개 이탈리안 와인에 대한 13가지 화학적 성분 rattle

# install.packages("rattle")

data(wine, package = "rattle")
head(wine)

# 변수의 측정단위(또는 범위) 상이하므로 scale함수를 이용 표준화를 수행하고 적절한 군집수 정함
df <- scale(wine[-1])
wssplot(df) # clster 수 3에서 크게 감소 후보 클러스터 수 3

# Nbclust 이용 군집수 확정
# install.packages("NbClust")
library(NbClust)
set.seed(1234)
nc <- NbClust(df, min.nc = 2, max.nc = 15, method = "kmeans")
table(nc$Best.nc[1,])

barplot(table(nc$Best.nc[1,]),
        xlab = "Number of Clusters",
        ylab = "Number of Criteria",
        main = "Number of Clusters Chosen by 26 Criteria"
        ) # 군집의 수를 3으로 추천

# k = 3으로 kmeans() 수행
set.seed(1234)
fit.km <- kmeans(df, 3, nstart = 25)

fit.km$size
fit.km$centers

plot(df, col=fit.km$cluster)
points(fit.km$centers, col=1:3, pch=8, cex=1.5)

# 각 군집별로 변수의 요약값을 측정단위의 척도로 나타내면...
aggregate(wine[-1], by=list(cluster=fit.km$cluster), mean)

ct.km <- table(wine$Type, fit.km$cluster)
ct.km

# flexclust의 randIndex() 함수 : 실제와인종류와 군집간의 일치도를 나타내는 수정된 순위지수
# -1 = noagree, 1 = agree
# install.packages("flexclust")
library(flexclust)
randIndex(ct.km)

# 예제2 {flexclust} 의 kcca() 함수 이용 k=평균군집 수행
library(flexclust)
data("Nclus")
plot(Nclus)

cl <- kcca(Nclus, k=4, family = kccaFamily("kmeans"))
image(cl)
points(Nclus)

barplot(cl)
stripes(cl)

# 예제 3. {cclust} cclust() 함수 이용 k-평균군집 수행
# install.packages("cclust")
library(cclust)
cl.1 <- cclust(Nclus, 4, 20, method = "kmeans")
plot(Nclus, col=cl.1$cluster)
points(cl.1$center, col = 1:4, pch = 8, cex=1.5)

# {cluster} clusplot()
library(cluster)
clusplot(Nclus, cl.1$cluster)

# 3.혼합 분포 군집

# 예제 1. {mixtools} normalmixEM()
# faithful : 올드페이스풀 간헐천의 분출간의 시간자료
# install.packages("mixtools")
library(mixtools)
data(faithful)
attach(faithful)

hist(waiting, main="Time between Old Faithful eruption", xlab="Minutes", ylab="", cex.main=1.5, cex.lab=1.5, cex.axis=1.4)

wait1 <- normalmixEM(waiting, lambda = .5, mu = c(55,80), sigma = 5)
wait1

summary(wait1)

plot(wait1, density = TRUE, cex.axis=1.4, cex.lab=1.4, cex.main=1.8, main2 = "Time between Old Faithful eruption", xlab2 = "Minutes")

# 예제 2 {mclust} Mclust() 함수
# install.packages("mclust")

library(mclust)

mc <- Mclust(iris[,1:4], G = 3)
summary(mc, parameters = TRUE)

plot.Mclust(mc) # SELECT 2

# 각 개체가 어느 그룹으로 분류되었는지 확인
str(mc)
mc$classification

# 새로운 자료 분류
predict(mc, data=)

# 4. SOM( Self Organizing Maps)

# install.packages("som")
# library(som)
# som(iris, grid=somgrid(), rlen = 100, alpha = c(0.05,0.01), init, toroidal = FALSE, keep.data = TRUE) # 오류발생

# 예제 1. kohonen 제공 wines 데이터 이용 SOM 군집 분석

install.packages("kohonen")
library(kohonen)
data("wines")

str(wines)
head(wines)

wines.sc <- scale(wines)
set.seed(7)
wine.som <- som(
  data = wines.sc,
  grid = somgrid(5,4,"hexagonal"),
  rlen = 100,
  alpha = c(0.05, 0.01),
  toroidal = FALSE,
  keep.data = TRUE
)

plot(wine.som, main = "Wine Data")
summary(wine.som)

par(mfrow = c(1,3))
plot(wine.som, type = "counts", main = "Wine data : counts")
plot(wine.som, type = "quality", main = "Wine data : mapping quality")
plot(wine.som, type = "mapping", labels = wine.classes, col=wine.classes, main = "Mapping plot")

par(mfrow = c(1,3))
colour1 <- tricolor(wine.som$grid)
plot(wine.som, "mapping", bg = rgb(colour1))

colour2 <- tricolor(wine.som$grid, phi = c(pi/6, 0, -pi/6))
plot(wine.som, "mapping", bg = rgb(colour2))

colour3 <- tricolor(wine.som$grid, phi = c(pi/6, 0, -pi/6), offset = .5)
plot(wine.som, "mapping", bg = rgb(colour3))

# unit 사이 거리 계산법
# unit.distances(grid, toroidal)

par(mfrow = c(1,2))


dists <- unit.distances(wine.som$grid, toroidal = FALSE)
plot(wine.som, 
     type="property", 
     property=dists[1,],
     main="Distances to unit 1",
     zlim=c(0,6),
     palette = rainbow,
     ncolors = 7,
     contin = TRUE
)

dists <- unit.distances(wine.som$grid, toroidal = FALSE)
plot(wine.som, 
     type="property", 
     property=dists[1,],
     main="Distances to unit 1",
     zlim=c(0,2),
     palette = rainbow,
     ncolors = 2,
     contin = TRUE
)

# 데이터가 학습되는 동안 유사도의 변화
data("wines")
wines.sc <- scale(wines)

set.seed(7)

wine.som <- som(data = wines.sc,
                grid = somgrid(5,4,"hexagonal"),
                rlen = 100,
                alpha = c(0.05, 0.01),
                toroidal = FALSE,
                keep.data = TRUE
                )

wine.som_1 <- som(data = wines.sc,
                  grid = somgrid(5,4,"hexagonal"),
                  rlen = 500,
                  alpha = c(0.05, 0.01),
                  toroidal = FALSE,
                  keep.data = TRUE
                )
par(mfrow = c(1,2))

plot(wine.som, type = "changes", main = "Wind data : SOM(Learning no = 100)")
plot(wine.som_1, type = "changes", main = "Wind data : SOM(Learning no = 500)")

library(ggplot2)

wines.sc=as.data.frame(wines)
wines.sc$clusterX <- wine.som$grid$pts[wine.som$unit.classif, "x"]
wines.sc$clusterY <- wine.som$grid$pts[wine.som$unit.classif, "y"]

p <- ggplot(wines.sc, aes(clusterX,clusterY))
p + geom_jitter(position = position_jitter(width = 0.4, height = 0.3))

