# 처리할 데이터 파일 불러오기
hwdata <- read.csv("hwdata.csv", encoding = "UTF-8")
hwdata

# 도로형태_대분류 4가지
road_pattern <- c("단일로", "교차로", "철길건널목", "기타/불명")
road_pattern


# 데이터 전처리

accident_numbers <- hwdata$사고건수
accident_numbers

# '도로형태_대분류' 항목별 건수
accident_numbers <- c(sum(accident_numbers[1:5]), sum(accident_numbers[6:8]), 
                      accident_numbers[9], accident_numbers[10])

# 전체 사고건수에서 '도로형태_대분류' 별로 차지하는 비율
# '철길건널목' 수치는 0.002%로 0%로 표시됨
pct <- round(accident_numbers/sum(accident_numbers)*100, 0)
pct

# 라벨링
label <- paste(road_pattern, " ", pct, "%", sep="")
label

# 파이 차트에 쓰일 색상 설정
colors <- c("lightcyan", "lavender", "lightgreen", "lightpink")

# 파이 차트로 시각화
pie(accident_numbers, labels = label, col = colors, 
    main = "도로형태별 사고건수비율",
    init.angle = 180, clockwise = T)