# Ch2. 외부 데이터 불러오기

# 1. get CSV File
data1 <- read.table("/Users/donghunhan/Desktop/data.csv",header = T,sep = ",")
data2 <- read.csv("/Users/donghunhan/Desktop/data.csv",header = T)

# 2. get Text File
data3 <- read.table("/Users/donghunhan/Desktop/test.txt")

# 3. get Excel 파일
install.packages("RODBC")
library(RODBC)
new <- odbcConnectExcel("a.xls")
yourdata <- sqlFetch(new,"Sheet1")
close(new)


