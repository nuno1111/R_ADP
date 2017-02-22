# 신경망 모형
library(nnet)

nn.iris <- nnet(Species~., data = iris, size=2, rang=0.1, decay=5e-4, maxit=200)

summary(nn.iris)

# 신경망 시각화 1
# install.packages("devtools")
library(devtools)
source_url('https://gist.githubusercontent.com/Peque/41a9e20d6687f2f3108d/raw/85e14f3a292e126f1454864427e3a189c2fe33f3/nnet_plot_update.r')

plot.nnet(nn.iris)

# 신경망 시각화 2
# install.packages("clusterGeneration")
# install.packages("scales")
# install.packages("reshape")

library(clusterGeneration)
library(scales)
library(reshape)

plot(nn.iris)

# 정.오. 분류표 (confusion matrix)
table(iris$Species, predict(nn.iris, iris, type="class"))

# infert 자연유산/인공유산 후 불임에 대한 사례-대조 연구

data(infert, package = "datasets")
str(infert)

# install.packages("neuralnet")
library(neuralnet)

net.infert <- neuralnet(case~age+parity+induced+spontaneous, data = infert, hidden = 2, err.fct = "ce", linear.output = FALSE, likelihood = TRUE )
net.infert
plot(net.infert)

names(net.infert)

net.infert$result.matrix

net.infert$data # 전체자료
net.infert$covariate # 모형 적합에 사용된 자료
net.infert$response # 모형 적합에 사용된 자료
net.infert$result # 모형 적합

out <- cbind(net.infert$covariate, net.infert$net.result[[1]])
dimnames(out) <- list(NULL, c("age","parity","induced","spontaneous","nn-output"))
head(out)

net.infert$startweights # 가중치의 초기값
net.infert$weights # 가중치의 적합값

head(net.infert$generalized.weights[[1]]) #일반화가중치

par(mfrow=c(2,2))
gwplot(net.infert, selected.covariate = "age", min = -2.5, max = 5)
gwplot(net.infert, selected.covariate = "parity", min = -2.5, max = 5)
gwplot(net.infert, selected.covariate = "induced", min = -2.5, max = 5)
gwplot(net.infert, selected.covariate = "spontaneous", min = -2.5, max = 5)
par(mfrow=c(1,1))

# age의 영향도가 적으므로 age 삭제 후 재실행

net.infert <- neuralnet(case~parity+induced+spontaneous, data = infert, hidden = 2, err.fct = "ce", linear.output = FALSE, likelihood = TRUE )

par(mfrow=c(2,2))
gwplot(net.infert, selected.covariate = "parity", min = -2.5, max = 5)
gwplot(net.infert, selected.covariate = "induced", min = -2.5, max = 5)
gwplot(net.infert, selected.covariate = "spontaneous", min = -2.5, max = 5)
par(mfrow=c(1,1))

# 각 뉴런의 출력값 계산 & 새로운 공변량 조합에 대한 예측값 age=22, parity=1, induced <= 1, spontaneous <= 1
new.output <- compute(net.infert, covariate = matrix(c(22,1,0,0,
                                                       22,1,1,0,
                                                       22,1,0,1,
                                                       22,1,1,1),
                                                     byrow = TRUE, ncol = 4))

new.output$net.result # 예측확률 증가

# 가중치에 대한 신뢰구간
confidence.interval(net.infert, alpha = 0.5)

# 3. 다층 신경망
train.input <- as.data.frame(runif(50, min = 0, max = 100))
train.output <- sqrt(train.input)
train.data <- cbind(train.input, train.output)

colnames(train.data) <- c("Input","Output")
head(train.data)

# 1 개의 은닉층과 10개의 은닉노드
# threshold= 옵션은 오차함수의 편미분에 대한 값으로 정지규칙으로 사용

net.sqrt <- neuralnet(Output~Input, train.data, hidden = 10, threshold = 0.01)
net.sqrt

plot(net.sqrt)

test.data <- as.data.frame((1:10)^2)
test.out <- compute(net.sqrt, test.data)
ls(test.out)

test.out$net.result

# 2 개의 은닉층 모형 10개 , 8개
net2.sqrt <- neuralnet(Output~Input, train.data, hidden = c(10,8), threshold = 0.01)
net2.sqrt

plot(net2.sqrt)

test2.out <- compute(net2.sqrt, test.data)
test2.out$net.result





















