install.packages("XML")
install.packages("ggplot2")
library(XML)
library(ggplot2)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"

api_key <- "a0Gi3VpYVJBWzUjoLfUHUR8ZPzSIzyi1uQlMFC/pZp/2xEpAIOHiysjurVrBODdaSHRl79MU8bawj5CDMHSgew=="

# 10에서 5로 변경
numOfRows <- 5
pageNo <- 1
# 'PM10'에서 'O3'로 변경
itemCode <- "O3"
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

df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

# 막대 그래프로 시각화
ggplot(data = df, aes(x = dataTime, y = seoul, fill = dataTime)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "none") +
  labs(title = "시간대별 서울지역의 오존(O3) 농도 변화",
       x = "측정일시", y = "농도") +
  scale_fill_manual(values = rainbow(5))