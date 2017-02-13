# Ch7.기타 유용한 기능들

# 1. paste : 입력받은 문자열을 하나로 합쳐줌
number=1:10
alphabet=c("a","b","c")
paste( number, alphabet )
paste( number, alphabet , sep = " to the ")

# 2. substr : 특정문자열 추출
substr("BigDataAnalysis",1,4)

country=c("Korea","Japan","China","Singapore","Russia")
substr(country, 1, 3)

# 3. as : 자료형 데이터 구조 변환

# as.data.frame(x) : 데이터프레임형식
# as.list(x) : 리스트 형식 변환
# as.matrix(x) : 행렬 형식으로 변환
# as.vector(x) : 벡터 형식으로 변환
# as.factro(x) : 팩터 형식으로 변환

# 강제형변환
as.integer(3.14) # 3
as.numeric("foo") # 오류
as.logical(0.45) # True

mydat
as.matrix(mydat) # 데이터프레임을 행렬로 변환

# 4. 문자열을 날짜로 변환
# 기본 : yyyy-mm-dd
# 다른형식 : 'format=' 이용 ex) mm/dd/yy => 'format="%m/%d/%Y"'

Sys.Date() # 현재날짜
as.Date() # 날짜 객체로 변환

as.Date("2015-01-13") # 정상
as.Date("01/13/2015") # 오류
as.Date("01/13/2015",format="%m/%d/%Y")

# 5. 날짜를 문자열로 변환
# format(데이터,포맷)
# as.character()

as.Date("08/13/2013",format="%m/%d/%Y")
format(Sys.Date())
as.character(Sys.Date())
format(Sys.Date(),format="%m/%d/%Y")

format(Sys.Date(),'%a') # '요일'출력
format(Sys.Date(),'%b') # '월'출력
format(Sys.Date(),'%m') # 두 자리 숫자 월
format(Sys.Date(),'%d') # 두 자리 숫자 일
format(Sys.Date(),'%y') # 두 자리 숫자 년도
format(Sys.Date(),'%Y') # 네 자리 숫자 년도







