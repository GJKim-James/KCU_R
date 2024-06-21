# 파이 차트  
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
#colors <- c("red", "orange", "yellow", "green", "lightblue", "blue", "violet")
#colors <- c("red", "orange", "yellow", "green", "lightblue", "cyan", "lavender")
#colors <- rainbow(7)
colors <- topo.colors(7)

pie(pm25, 
    labels = city, 
    col = colors, 
    main = "지역별 초미세먼지 농도")  # default : 반시계 방향

pie(pm25, 
    labels = city, 
    col = colors, 
    main = "지역별 초미세먼지 농도",
    init.angle = 90, clockwise = T)

# 사용 가능한 색 찾기
colors()

# 팔레트
install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

display.brewer.pal(9, name = 'Greens')

display.brewer.pal(6, name = 'Greens')

# 라벨 변경과 팔레트 사용
# install.packages("RColorBrewer")
# library(RColorBrewer)

greens <- brewer.pal(7, 'Greens')
set1 <- brewer.pal(7, "Set1")

# 미세먼지 농도를 백분율로 표현
# round(x, 2) : x 값을 소수 2자리까지 반올림하여 표시
pct <- round(pm25 / sum(pm25) * 100, 0)

# 지역명, 백분율, '%' 기호를 순서대로 공백 없이 붙임
city_label <- paste(city, ", ", pct, "%", sep="")

pie(pm25, 
    labels = city_label, 
    col = greens, 
    main = "지역별 초미세먼지 농도",
    init.angle = 90, clockwise = T)

pie(pm25, 
    labels = city_label, 
    col = set1, 
    main = "지역별 초미세먼지 농도", 
    init.angle = 90, clockwise = T)
