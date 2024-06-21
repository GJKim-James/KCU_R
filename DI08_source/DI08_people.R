# 지역별 순이동에 따른 워드 클라우드
install.packages("wordcloud")
library(wordcloud)

word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)
wordcloud(word, frequency, colors = "blue", scale = c(3, 1))

install.packages("wordcloud2")
library(wordcloud2)
datawf = data.frame(word, frequency, stringsAsFactors = FALSE)
wordcloud2(datawf, size = 0.2)

# 단어들의 모양, 색 변환
wordcloud(word, frequency, random.order = T, random.color = T,
          colors = rainbow(length(word)), scale = c(3, 1))

# 다양한 단어 색 출력을 위한 팔레트 패키지의 활용
install.packages("RColorBrewer")
library(RColorBrewer)
pal2 <- brewer.pal(8, "Dark2")
word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)
wordcloud(word, frequency, random.color = T, colors = pal2, scale = c(3, 1))

# 지역별 순이동 인구수에 따른 워드 클라우드
library(wordcloud)
library(RColorBrewer)
## 팔렛트 보기
display.brewer.all()
#####################
pal2 <- brewer.pal(8,"Dark2")


data <- read.csv(file.choose(), header = T)
head(data)

# '전국' 지역 통계 삭제
data2 <- data[data$행정구역.시군구.별 != "전국", ]
head(data2)

# '구’ 단위 지역 통계 삭제
x <- grep("구$", data2$행정구역.시군구.별)
data3 <- data2[-c(x), ]
data3=data2
head(data3)

# 순이동 인구수(전출보다 전입 인구수)가 많은 지역
data4 <- data3[data3$순이동.명>0, ]
word <- data4$행정구역.시군구.별
frequency <- data4$순이동.명
wordcloud(word, frequency, colors=pal2)

# 순이동 인구수(전입보다 전출 인구수)가 많은 지역
data5 <- data3[data3$순이동.명<0, ]
word <- data5$행정구역.시군구.별
frequency <- abs(data5$순이동.명)
wordcloud(word, frequency, colors=pal2)


#datawf=data.frame(word,frequency,stringsAsFactors = FALSE)
