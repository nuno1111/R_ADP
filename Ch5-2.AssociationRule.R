## 연관분석
# 실습 1. {arules} Adult
# install.packages("arules")

library(arules)

data(Adult)

str(Adult)
summary(Adult)

Adult.df <- as(Adult,"data.frame")
head(Adult.df)

rules <- apriori(Adult)

# inspect 함수 : apriori 함수를 통해 발견된 규칙 보여줌
inspect(head(rules))

adult.rules <- apriori(
                      Adult,
                      parameter = list(support = 0.1, confidence = 0.6),
                      appearance = list(rhs = c('income=small','income=large'), default='lhs'),
                      control = list(verbose=F)
                      )

adult.rules.sorted <- sort(adult.rules, by='lift')
inspect(head(adult.rules.sorted))

# 연관규칙 시각화 패키지 arulesViz
# install.packages("arulesViz")
library(arulesViz)
plot(adult.rules.sorted, method="scatterplot")
plot(adult.rules.sorted, method="graph", control = list(type='items', alpha=0.5))





