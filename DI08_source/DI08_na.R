#[소스 참고 사이트]
# https://blog.naver.com/haetban2/221597364927
#[KONLP 설치 참고 사이트] 
# https://mrchypark.github.io/post/KoNLP-%EC%84%A4%EC%B9%98-%EB%B0%A9%EB%B2%95/
# https://rdmkyg.blogspot.com/2022/06/r-42-windows-rjava-kolnp.html

#** 주의 사항 반드시 순서대로 따라하세요. 
# [1] 아래 사이트에서 자바를 다운 받아서 설치하세요.  
# https://www.oracle.com/java/technologies/downloads/#jdk18-windows
# Windows - x64 Installer 를 설치


# [2] 아래사이트를 참고하여 자바 환경 변수 설정
# https://marobiana.tistory.com/163
# <설정사항 >
# JAVA_HOME은 C:\Program Files\Java\jdk-18.0.2.1 (본인의 java 설치 디렉토리 확인하여 설정)
# CLASSPATH는 %JAVA_HOME%\lib
# 시스템 변수 path에 %JAVA_HOME%\bin 을 추가 

# [3] KONLP 설치
install.packages("rJava")
install.packages("multilinguer")

# 의존성을 설치 한다. 
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")

# Git hub로 설치 한다. 
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

#[4] scala-library-2.11.8을 다운 받아서 KONLP java 디렉토리에 복사한다. 
# https://1drv.ms/u/s!AiTTquXjsPXAjLVvKq9gXdkMj5mAjQ?e=8L0u7 에서 파일을 다운받아서 
# 설치 디렉토리는 https://rdmkyg.blogspot.com/2022/06/r-42-windows-rjava-kolnp.html 문서 참조 


library(KoNLP)

useSystemDic()
useSejongDic()
useNIADic()

# 애국가 행 단위로 읽기
national_anthem <- readLines("national_anthem.txt")
national_anthem

# 명사 추출하기
national_anthem_noun  <- extractNoun(national_anthem)
national_anthem_noun

# 사전에 단어 추가
add_words <- c("달", "구름", "백두산", "하느님")
buildDictionary(user_dic = data.frame(add_words, rep("ncn", length(add_words))), replace_usr_dic = T)
# rep은 동일한 과정을 반복하는 함수. "ncn"은 비서술성명사로 설정하는 코드

# 다시 변수 할당 - 명사 추출
# sapply : 결과를 벡터 or 행렬 형태로 반환
# USE.NAMES = T : 단어 결과 위에 본문의 각 행이 포함
national_anthem_noun  <- sapply(national_anthem, extractNoun, USE.NAMES = F)
national_anthem_noun


# 편하게 처리하기 위해 벡터로 변환
national_anthem_vector <- unlist(national_anthem_noun)
national_anthem_vector

# 사용 빈도 확인하기
national_anthem_table <- table(national_anthem_vector)
national_anthem_table

# 숫자나 공백이 포함된 것을 제외하기
# Filter() 함수는 내부에서 function을 통해 별도의 함수를 만들 수 있음
# nchar()이라는 길이를 구해주는 함수를 사용해서 두 글자 이상인 단어만 변수에 할당
# 만약 정확하게 제외하고 싶은게 있다면 gsub 함수 사용
national_anthem_vector2 <- Filter(function(x) {nchar(x) >= 2}, national_anthem_vector)
national_anthem_vector2
national_anthem_table2 <- table(national_anthem_vector2)
national_anthem_table2

national_anthem_vector3 <- national_anthem_vector2
national_anthem_vector3 <- gsub("구름없", "구름", national_anthem_vector3)
national_anthem_vector3 <- gsub("우리기", "우리", national_anthem_vector3)
national_anthem_vector3 <- gsub("공활한데", "", national_anthem_vector3)
national_anthem_vector3 <- gsub("하사", "", national_anthem_vector3)

national_anthem_vector3 <- Filter(function(x) {nchar(x) >= 2}, national_anthem_vector3)
national_anthem_vector3
national_anthem_table3 <- table(national_anthem_vector3)
national_anthem_table3

# 정렬하기
# sort() 함수를 통해 빈도순으로 정렬
sort(national_anthem_table2, decreasing = T)
sort(national_anthem_table3, decreasing = T)

#install.packages("wordcloud2")
library(wordcloud2)

wordcloud2(national_anthem_table2)
wordcloud2(national_anthem_table3)

wordcloud2(national_anthem_table2, col = "random-light", backgroundColor = "ivory", shape = "star")

wordcloud2(national_anthem_table3, col = "random-light", backgroundColor = "blue", shape = "pentagon", fontFamily = "Gulim")
wordcloud2(national_anthem_table3, col = "random-light", backgroundColor = "blue", shape = "pentagon", fontFamily = "Nanum Gothic")
