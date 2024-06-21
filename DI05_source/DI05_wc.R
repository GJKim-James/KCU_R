# 워드 클라우드로 보는 지역별 미세먼지 현황

# 지진 발생 지역 출력
install.packages("wordcloud")
library(wordcloud)

city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
wordcloud(city, freq = pm25, colors = rainbow(3), random.color = T)
