#https://blog.naver.com/PostView.nhn?blogId=jjuna91&logNo=222083415936&parentCategoryNo=&categoryNo=29&viewDate=&isShowPopularPosts=true&from=search
install.packages('rvest')
library(rvest)

url <- "https://news.sbs.co.kr/news/newsHotIssueList.do?tagId=10000050973&plink=TOPWORD&cooper=SBSNEWSEND"
root_url <-"https://news.sbs.co.kr"

###사용할 기사들 url 주소 따오기
read_html(url) %>% 
  html_nodes("a.news") %>% 
  html_attr("href") -> site_url
site_url

#site <- paste0(root_url, site_url)
#site


### 반복문 사용해서 기사 타이틀 따오기 
title <- NULL

for (j in 1:length(site_url)) {
  
  read_html(site_url[j]) %>% 
    html_nodes("h1#news-title") %>% 
    html_text() -> tit
  
  title <- c(title, tit)
  
}

title


### 반복문 사용해서 기사내용 따오기 
article <- NULL

for (i in 1:length(site_url)) {
  
  read_html(site_url[i]) %>% 
    html_nodes("div.text_area") %>% 
    html_text() %>% 
    trimws() -> body
  # trimws() : 양쪽 공백 제거 함수
  article <- c(article, body)
  
}

article <- gsub("\n", "", article)
article


install.packages("tidyverse")
library(tidyverse)

# tibble : tidy data에서 사용하는 R 데이터 객체, dataframe과 비슷(대용량에 유리)
summary <- tibble(title, article)
summary

write.csv(summary, "articletest.csv")


### 저장한 데이터 로드해서 분석
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(rvest)
library(dplyr)
library(wordcloud2)

article <- read.csv("articletest.csv")
article <- gsub("<앵커>", "", article)
article <- gsub("<기자>", "", article)


sum_body <- article[3]

nouns <- extractNoun(sum_body)

wordcount <- table(unlist(nouns))
toplist <- as.data.frame(wordcount, stringsAsFactors = F)


# 구조 확인
glimpse(toplist)

toplist <- filter(toplist, nchar(Var1) >= 2)

head(toplist)
toplist <- rename(toplist,
                  word = Var1,
                  freq = Freq)

toplist <- arrange(toplist, desc(freq))
head(toplist)
tail(toplist)


wc <- wordcloud2(data = toplist, size = 1, color = "random-light", 
                 backgroundColor = "white", rotateRatio = 0.75)
wc

toplist

wordcloud2(toplist)
