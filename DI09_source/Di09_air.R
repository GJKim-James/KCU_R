# 미세먼지 농도의 시간대별 변화 : 막대 그래프

# 미세먼지 XML 문서 출력
install.packages("XML")
install.packages("ggplot2")
library(XML)
library(ggplot2)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"

# 자신의 api_key 쓰기 일반 인증키 (Decoding)을  사용
# api_key <- "자신의 api_key쓰기"

############################################
api_key <- "a0Gi3VpYVJBWzUjoLfUHUR8ZPzSIzyi1uQlMFC/pZp/2xEpAIOHiysjurVrBODdaSHRl79MU8bawj5CDMHSgew=="
##############################################


####인증키 삭제해서 제공할 것 #################


numOfRows <- 10
pageNo <- 1
itemCode <- "PM10"
dataGubun <- "HOUR"
searchCondition <- "MONTH"

url <- paste(api,
             "?serviceKey=", api_key,
             "&numOfRows=", numOfRows,
             "&pageNo=", pageNo,
             "&itemCode=", itemCode,
             "&dataGubun=", dataGubun,
             "&searchCondition=", searchCondition,
             sep="")
url

xmlFile <- xmlParse(url)
xmlRoot(xmlFile)


# XML 문서를 데이터 프레임으로 변환
df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

# 미세먼지 농도의 그래프
ggplot(data = df, aes(x = dataTime, y = seoul)) +
  geom_bar(stat = "identity", fill = "green")

# 라벨 수정
ggplot(data = df, aes(x = dataTime, y = seoul)) +
  geom_bar(stat = "identity", fill = "green") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "시간대별 서울지역의 미세먼지 농도 변화", 
       x = "측정일시", y = "농도")

# 막대 색
ggplot(data = df, aes(x = dataTime, y = seoul, fill = dataTime)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "시간대별 서울지역의 미세먼지 농도 변화",
       x = "측정일시", y = "농도") +
  scale_fill_manual(values = rainbow(10))

# 범례 삭제
ggplot(data = df, aes(x = dataTime, y = seoul, fill = dataTime)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "none") +
  labs(title = "시간대별 서울지역의 미세먼지 농도 변화",
       x = "측정일시", y = "농도") +
  scale_fill_manual(values = rainbow(10))

# 가로로 막대 출력
ggplot(data = df, aes(x = dataTime, y = seoul, fill = dataTime)) +
  geom_bar(stat = "identity") +
  theme(legend.position = "none") +
  labs(title = "시간대별 서울지역의 미세먼지 농도 변화",
       x = "측정일시", y = "농도") +
  scale_fill_manual(values = rainbow(10)) +
  coord_flip()
