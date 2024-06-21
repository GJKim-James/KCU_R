#https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html#install-wordcloud2

#설치
#install.packages("wordcloud2")

# 설치가 안되면 
#require(devtools)
#install_github("lchiffon/wordcloud2")
 
library(wordcloud2)
wordcloud2(data = demoFreq)
head(demoFreq)

# 색상 및 배경색 사용
wordcloud2(demoFreq, color = "random-light", backgroundColor = "grey")

# 모양 사용
wordcloud2(demoFreq, color = "random-light", shape = "diamond", backgroundColor = "grey")

wordcloud2(demoFreq, color = "random-dark", shape = "triangle", backgroundColor = "yellow")

# 회전 사용(pi = 180도)
wordcloud2(demoFreq, minRotation = -pi/6, maxRotation = -pi/6, minSize = 10,
           rotateRatio = 1)
