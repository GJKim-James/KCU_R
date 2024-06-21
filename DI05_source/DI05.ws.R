# 웹스크래핑 : 공공데이터 포털의 API 목록 출력
install.packages("rvest")
library(rvest)

url <- "https://www.data.go.kr/tcs/dss/selectDataSetList.do"

#url <- "https://www.data.go.kr/data/3077867/fileData.do"
html <- read_html(url)
html
