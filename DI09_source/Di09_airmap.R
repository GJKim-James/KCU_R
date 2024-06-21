# 지역별 미세먼지 농도 비교: 지도

# 미세먼지 XML 문서 출력
install.packages("XML")
install.packages("ggplot2")
install.packages("ggmap")
library(XML)
library(ggplot2)
library(ggmap)

api <- "http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst"


#### 구글키 발급 받아서 넣기 ######
##구글키 발급 받는 방법
# https://datadoctorblog.com/2021/01/29/etc-google-cloud-platform-geocoding/
#https://www.thewordcracker.com/basic/%EA%B5%AC%EA%B8%80%EC%A7%80%EB%8F%84%EA%B0%80-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EB%A1%9C%EB%93%9C%EB%90%98%EC%A7%80-%EC%95%8A%EB%8A%94-%EB%AC%B8%EC%A0%9C/


# register_google(key = "자신의 api_key쓰기")

register_google(key = '                                  ')


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
xmlFile <- xmlParse(url)

# 특정 시간대의 지역별 미세먼지 농도 추출
df <- xmlToDataFrame(getNodeSet(xmlFile, "//items/item"))
df

pm <- df[1, 1:16]
pm

# 지역별 미세먼지 농도의 지도 출력

cities <- c("대구시", "충청남도", "인천시", "대전시", "경상북도",
            "세종시", "광주시", "전라북도", "강원도", "울산시",
            "전라남도", "서울시", "부산시", "제주시", "충청북도",
            "경상남도")
gc <- geocode(enc2utf8(cities))
gc

# 미세먼지 = t(pm) 은 행으로 된 데이터를 열 형태로 바꿔주는 역할
df2 <- data.frame(지역명 = cities,
                     미세먼지 = t(pm),
                     경도 = gc$lon,
                     위도 = gc$lat,
                     stringsAsFactors = F)
df2

names(df2)[2] <- "미세먼지"
df2

str(df2)

# 문자형으로 표시된 미세먼지 농도를 숫자형으로 변경
# 지도에 나타내려면 숫자형이어야 함
df2[,2] <- as.numeric(df2[,2])
cen <- as.numeric(geocode(enc2utf8("전라북도")))
map <- get_googlemap(center = cen, zoom = 7, maptype = "roadmap")

ggmap(map) +
  geom_point(data = df2,
             aes(x = 경도, y = 위도),
             color = rainbow(length(df2$미세먼지)),
             size = df2$미세먼지 * 0.3,
             alpha = 0.5)

