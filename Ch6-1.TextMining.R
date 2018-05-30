# 텍스트 마이닝 

###### R 에서 트위터 사용을 위한 기본 Setting ######
# 1. twitter 계정 만들기
# 2. twitter에 접속한 후 application 설정하기
# 3. comsumer key, consumer secret, access token, access token secret 입력하기

api_key <- "zEHJWGn4qhuKn773TKmn2IZ9O"
api_secret <- "AhIc3SOYhZLSJqSK8LUWLtEvI0yoC3ybNrAV2QepAYQu9Yf8tj"
access_token <- "135695395-zJfB2FjY4XQtIb1PdPXaYcp6P8RQU9B7Wwbcf4yn"
access_token_secret <- "eZMHz2aJPNqyZ4treENb3b6aRJZqicBTp8yOrXOO1nMQL"

# install.packages("tm")
library(tm)

# install.packages("twitteR")
library(twitteR)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

# 예제 1. bigdata 단어가 등장한 트위터 메시지
keyword <- 'trump'
# keyword <- enc2utf8(keyword)

bigdata.tw <- searchTwitter(keyword, since = '2018-05-24',n=1000,lang='en')
# bigdata.tw <- searchTwitter(keyword, since = '2018-05-21',n=1000)

bigdata.tw[1:3]

tweet <- bigdata.tw[[1]]

tweet$getScreenName() # 작성자 
tweet$getText()       # 트위터 내용

class(bigdata.tw)
bigdata.df <- twListToDF(bigdata.tw) # 트위터리스트 데이터프레임으로 변환
class(bigdata.df)
bigdata.text <- bigdata.df$text # 텍스트만 추출
# Encoding(bigdata.text)  <- "UTF-8"

###### 데이터 전처리 및 가공 ######
# Corpus 생성

# txt <- system.file('texts','txt', package = 'tm') # 파일가져올 폴더지정
# ovid <- Corpus(DirSource(txt), readerControl = list(language='lat')) # 해당폴더에서 파일 5개가져오기
# ovid
# ovid[[1]]$content

# getReaders() #reader의 종류 word, pdf, xml 등 가

my.corpus <- Corpus(VectorSource(bigdata.text)) # 트위터 데이터 Corpus생성
my.corpus
my.corpus[[1]]
my.corpus[[1]]$content # 1번째 트위터 텍스트 확인

tm::inspect(my.corpus[1:5]) # 코퍼스탐색

# tm_map함수적용 : 전처리 가공 함수
# getTransformations() # 기본전처리함수목록

my.corpus <- tm_map(my.corpus, stripWhitespace) # 기본 Transformation 함수 : 빈공간(\n) 제거

# @뒤 단어제거
my.corpus <- tm_map(my.corpus, content_transformer(gsub), pattern='@\\S*', replacement='')

# http로 시작되는 URL 제거
my.corpus <- tm_map(my.corpus, content_transformer(gsub), pattern='http\\S*', replacement='')

# 문장 부호 및 구두점 제거
my.corpus <- tm_map(my.corpus, removePunctuation)

# 소문자로 일괄변경
my.corpus <- tm_map(my.corpus, content_transformer(tolower))

# 특정단어 제거
stopwords('en')
my.corpus <- tm_map(my.corpus, removeWords, stopwords('en'))
mystopword <- c(stopwords('en'),'rt','via','even','character')
my.corpus <- tm_map(my.corpus, removeWords, mystopword)# 단어지정 제거

###### 자연어처리 ######
# stemming : 공통어간단어 묶기
# stemDocument : 스테밍하기
# stemCompletion : 스테밍 + 단어완성

# install.packages("SnowballC")
# library(SnowballC)
# test <- stemDocument(c('updated','update','updating'))
# stemCompletion(test, dictionary = c('updated','update','updating'))

# dict.corpus <- my.corpus # stemCompletion용 dictionary 생성
# my.corpus <- tm_map(my.corpus, stemDocument) # 스테밍 수행

# stem 후 NA 생성 방지 함수 생성
# stemCompletion_mod <- function(x,dict){
#   PlainTextDocument(
#     stripWhitespace(
#       paste(
#         stemCompletion(
#           unlist(
#             strsplit(
#               as.character(x)," "
#             )
#           ),
#           dictionary = dict, type='first'
#         ),
#       sep="", collapse = " "
#       )
#     )
#   )
# }
# 
# my.corpus <- lapply(my.corpus, stemCompletion_mod, dict = dict.corpus)
# my.corpus <- Corpus(VectorSource(my.corpus))

# 한글처리
# install.packages('KoNLP')
# library(rJava)
# library(KoNLP)
# extractNoun("연습을 해보고자 한다. 명사가 잘 추출되는지 보자, 빨간색으로 글씨를 쓰고 있다.")
# sapply("연습을 해보고자 한다. 명사가 잘 추출되는지 보자, 빨간색으로 글씨를 쓰고 있다.",extractNoun)

###### TDM 구축 (Term-Document Matrix) ######
# 모든단어
my.TDM <- TermDocumentMatrix(my.corpus)

# inspect frequent term
findFreqTerms(my.TDM, lowfreq = 10)

dim(my.TDM)
inspect(my.TDM[1:10, 1:10])

# 단어사전(dictionary)
# myDict <- c('bigdata','data','analyst','cloud','company','privacy','analytics','business','hadoop','datascience')
# my.TDM <- TermDocumentMatrix(my.corpus, control = list(dictionary=myDict))
# tm::inspect(my.TDM[,60:70])

###### 분석및 시각화 ######
# Association
findAssocs(my.TDM, enc2utf8('korea'), 0.2)

# wordcloud
# install.packages("wordcloud")
library(wordcloud)

my.TDM.m <- as.matrix(my.TDM)
term.freq <- sort(rowSums(my.TDM.m), decreasing = T)
head(term.freq, 15)

wordcloud(words=names(term.freq), freq = term.freq, min.freq = 15, random.order = F
          , random.color = T
          , colors = brewer.pal(8,'Dark2')
          )

### 형태소 분석 테스트 ###
char_list <- c('이번 예제는 텍스트 분석에서 많이 사용되는 tm 패키지와 KoNLP 패키지를 사용해서 나온 결과'
,'비교해서 보여 드리겠습니다. 예제로 사용할 파일은 국내 유명 호텔 중 2 곳을 이용한 고객들'
,'이용 후기를 모은 파일입니다. 이미 앞에서 KoNLP 패키지와 tm 패키지 설명은 다 했기 때문'
,'내용이 중복되어 여기서는 결과 화면과 소스 코드만 보여 드리겠습니다')

# library(KoNLP)
# noun_list <- sapply(char_list, extractNoun)
# noun_list
# 
# library(tm)
# ko.corpus <- Corpus(VectorSource(char_list)) # 트위터 데이터 Corpus생성
# ko.corpus[[1]]$content
# 
# ko.corpus.m <- tm_map(ko.corpus, extractNoun)
# ko.TDM <- TermDocumentMatrix(ko.corpus.m)
# 
# ko.TDM.m <- as.matrix(ko.TDM)
# 
# term.freq <- sort(rowSums(ko.TDM.m), decreasing = T)
# barplot(head(term.freq,10))
# 
# library(wordcloud)
# wordcloud(words=names(term.freq)
#           , freq = term.freq
#           , min.freq = 1
#           , random.order = F
#           , random.color = T
#           , colors = brewer.pal(8,'Dark2')
# )

#####################################################################
#                             sNA 분석                              #
#####################################################################

dim(my.TDM.m)
term.freq <- sort(rowSums(my.TDM.m), decreasing = T)
my.Term <- my.TDM.m[rownames(my.TDM.m) %in% names(term.freq[term.freq > 20]),] # 빈도수 20넘는 단어 추출

my.Term[my.Term >= 1] <- 1 # 1번이상은 모두 1로 변경

termMatrix <- my.Term %*% t(my.Term) # 단어와 단어 sna matrix 생성

# install.packages("igraph")
library(igraph)

g <- graph.adjacency(termMatrix, weight = T, mode = 'undirected')
g <- simplify(g) # 자기참조 등 중복제거

V(g)$label <- V(g)$name
head(V(g)$label,5)

V(g)$degree <- degree(g)
head(V(g)$degree,5)
plot(g)

layout1 <- layout.fruchterman.reingold(g) # 의미있는 layout으로 sna plot 생성
plot(g, layout = layout1)

V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree) + 0.2
V(g)$label.color <- rgb(0,0,0.2,0.8)
V(g)$frame.color <- NA

egam <- (log(E(g)$weight)+0.4) / max(log(E(g)$weight)+0.4)
E(g)$width <- egam
E(g)$color <- rgb(0.5,0.5,0,egam)
plot(g, layout = layout1)






