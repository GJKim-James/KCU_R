# 처리할 데이터 파일 불러오기
hwdata <- read.csv("hwdata.csv", encoding = "UTF-8")
hwdata

# 도로형태_대분류 4가지
road_pattern <- c("단일로", "교차로", "철길건널목", "기타불명")
road_pattern


# 데이터 전처리

# 사망자
dead <- hwdata$사망자수
dead
dead <- c(sum(dead[1:5]), sum(dead[6:8]), dead[9], dead[10])
dead

# 부상자(중상자 + 경상자)
injured <- hwdata$중상자수 + hwdata$경상자수
injured
injured <- c(sum(injured[1:5]), sum(injured[6:8]), injured[9], injured[10])
injured

# 사망자 수, 부상자 수 합치기
dead_injured <- rbind(dead, injured)
dead_injured

# 범례
legend_lbl <- c("사망자", "부상자")
legend_lbl

# 그룹형 바 차트로 시각화
barplot(dead_injured, main = "도로형태별 인명사고",
        names.arg = road_pattern,
        xlab = "도로종류", ylab = "명",
        col=c("darkblue","red"),
        legend.text=legend_lbl,
        ylim = c(0, 150000),
        args.legend = list(x = "topright"))