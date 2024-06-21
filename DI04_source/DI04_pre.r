install.packages('dplyr')
library(dplyr)

exam <- read.csv("DIexam.csv")
exam

#조건에 맞는 데이터 추출
exam %>% filter(major == 1)
exam %>% filter(major == 2)
exam %>% filter(major != 1)
exam %>% filter(major != 3)
  
exam %>% filter(r > 88)
exam %>% filter(r < 88) 
exam %>% filter(python >= 87) 
exam %>% filter(python <= 87) 
exam %>% filter(python == 87) 
exam %>% filter(python != 87) 

# 여러 조건을 충족하는 행 추출
exam %>% filter(major == 1 & r >= 95) 
  
# 여러 조건 중 하나 이상 충족하는 행 추출
exam %>% filter(r > 95 | python > 95)

# 1, 3 전공에 해당되면 추출 
exam %>% filter(major == 1 | major == 3) 
exam %>% filter(major %in% c(1, 3)) 

#해당 변수만 추출
exam %>% select(c)

exam %>% select(num, python) %>% head(3) 

#평균 구하기
major1 <- exam %>% filter(major == 1)
mean(major1$r)  
mean(major1$c)   

exam %>%  
     select(num, c) %>%  # num, c 추출 
     head(10)              # 앞부분 10행까지 추출 

##### 정렬 
  exam %>% arrange(r)         # r 오름차순 정렬 
  exam %>% arrange(desc(r))   # r 내림차순 정렬 
  exam %>% arrange(major, r)  # major 및 r 오름차순 정렬 
  exam %>% arrange(major, desc(r)) 
  ## -------------------------------------------------------------------- ## 
 exam %>% summarise(mean_r = mean(r))  # r 평균 산출 
 exam %>% 
     group_by(major) %>%              # major별로 분리 
     summarise(mean_r = mean(r))      # r 평균 산출 
  








