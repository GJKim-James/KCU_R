#설치한 패키지 삭제하기 위해서 
remove.packages('readxl')
install.packages('readxl')
library(readxl)
#update.packages()
#install.packages('Rcpp')
getwd()
setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI04_source")
#getwd()
exam_result <- read_excel("test.xlsx")
exam_result

mean(exam_result$python)
mean(exam_result$c)

exam_result_2 <- read_excel("test.xlsx")
exam_result_2

# 속성명이 없는 경우
exam_result_2 <- read_excel("test.xlsx", col_names = F)
exam_result_2


# 엑셀파일로 저장하기 위한 과정 1-4까지 설치와 로딩

# 1. openxlsx 패키지 설치와 로딩하기
install.packages('openxlsx')
library(openxlsx)

# 2. installr 패키지 설치와 로딩하기
install.packages("installr")
library(installr)

# 3. install.rtools() 실행
installr::install.rtools()

# 4. R_ZIPCMD 설정
Sys.setenv(R_ZIPCMD="C:/Rtools/bin/zip")

######################################

install.packages('writexl')
library(writexl)

# library(openxlsx) 
write.xlsx(exam_result, file = "exam_result.xlsx", colNames = TRUE)
# library(writexl)
#write_xlsx(exam_result, path = "exam_result.xlsx")
library(readxl)
exam_result<-read_excel("exam_result.xlsx")
exam_result

