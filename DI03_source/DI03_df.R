# 데이터 프레임

# 두 고객의 데이터 프레임 만들기
df <- data.frame(성명=c("알라딘", "자스민"), 
                   나이=c(20, 19), 
                   국어=c(70, 85))

# 열과 행 단위 추가
df <- cbind(df, 음악=c(80, 90))
df

df <- rbind(df, data.frame(성명="지니", 나이=30, 국어=90, 음악=75))
df

df <- rbind(df, data.frame(성명="자파", 국어=50, 음악=60,나이=52))
df

# 요소 값 보기
df[3, 2]

df[3,]

df[, 2]

df[-2,]

# 요소 값 수정
df <- data.frame(성명=c("알라딘", "자스민"), 나이=c(20, 19), 국어=c(70, 85))
str(df)
df

df[1, 2] <- 21
df

df[1,1] <- "Aladin"
df

#factor 아닌경우
df <- data.frame(성명=c("알라딘", "자스민"), 
                   나이=c(20, 19), 
                   국어=c(70, 85),
                   stringsAsFactors = F)
str(df)

df[1,1] <- "Aladin2"
df

#factor의 경우 유의
df <- data.frame(성명=c("알라딘", "자스민"), 
                   나이=c(20, 19), 
                   국어=c(70, 85),
                   stringsAsFactors = T)
str(df)

df[1,1] <- "Aladin"
df
df[1,1] <- "알라딘"
df

df <- data.frame(성명=c("알라딘", "자스민"), 
                   나이=c(20, 19), 
                   국어=c(70, 85),stringsAsFactors = F)
df[1,1] <- "지니"
df
