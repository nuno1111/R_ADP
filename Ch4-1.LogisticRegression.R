## 분류 분석 
## 1.로지스틱 회귀분석

data(iris)

a <- subset(iris, Species == "setosa" | Species == "versicolor" ) ## Y 값을 두개만 남기기

a$Species <- factor(a$Species)

str(a)

# 로지스틱 회귀분석 수행

b <- glm(Species~Sepal.Length, data = a ,family = binomial)
summary(b)

plot(b)

coef(b)
exp(coef(b)["Sepal.Length"]) ## Versicolor일 오즈가 exp(5.140) 값은 약 170배 증가

confint(b, parm = "Sepal.Length") # Confidence Intervals for Model Parameters : 신뢰구간

exp(confint(b, parm = "Sepal.Length"))

fitted(b)[c(1:5,96:100)] # 적합 결과 확인

predict(b, newdata = a[c(1, 50, 51, 100),], type = "response")

cdplot(Species~Sepal.Length, data=a) # Conditional Density Plots : 조건 부 플롯

plot(a$Sepal.Length, a$Species, xlab="Sepal.Length")
x = seq(min(a$Sepal.Length), max(a$Sepal.Length),0.1)
lines(x, 1+(1/(1+(1/exp(-27.8315 + 5.140*x)))), type="l", col="red")

# 예제 2. 다중 로지스틱 회귀, 생산 자동차
attach(mtcars)
str(mtcars)

glm.vs <- glm(vs~mpg+am, data = mtcars, family = binomial)

summary(glm.vs)

# 예측변수가 여러개일때 변수선택법 적용
step.vs <- step(glm.vs, direction = "backward")
summary(step.vs)

ls(glm.vs) # glm 이 가진 값
str(glm.vs) # glm 이 가진 값

#모델 적합도 , 변수 추가 단계별로 이탈도의 감소량과 유의성 검정결과 제시
anova(glm.vs, test = "Chisq")

1 - pchisq(18.327 ,1)
1 - pchisq(4.887 ,1)

































