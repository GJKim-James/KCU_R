# 바 차트 
dept <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
sales01 <- c(4, 12, 5, 8)
barplot(sales01, 
        names.arg = dept,
        main = "부서별 영업 실적(1분기)",
        col = rainbow(length(dept)),
        xlab = "부서", ylab = "영업 실적(억 원)",
        ylim = c(0, 15))

# 수평선(h : 수평선, v : 수직선)
abline(h = mean(sales01), col = "orange", lty = 2)
# a : y절편, b : 기울기 (y = bx + a)
abline(a = mean(sales01), b = 0, col = "black", lty = 2)

# 데이터 라벨 출력
bp <- barplot(sales01, names.arg = dept,
              main = "부서별 영업 실적(1분기)",
              col = rainbow(length(dept)),
              xlab = "부서", ylab = "영업 실적(억 원)",
              ylim = c(0, 15))

text(x = bp, y = sales01, labels = sales01, pos = 3)

# 바 차트의 회전(수평 바 차트)
barplot(sales01, names.arg = dept,
        main = "부서별 영업 실적(1분기)",
        col = rainbow(length(dept)),
        ylab = "부서", xlab = "영업 실적(억 원)",
        xlim = c(0, 15),
        horiz = TRUE)

# 스택형 바 차트
dept <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
sales01 <- c(4, 12, 5, 8)
sales02 <- c(12, 8, 8, 4)
sales <- rbind(sales01, sales02)
sales

legend_lbl <- c("1 분기", "2 분기")
barplot(sales, main = "부서별 영업 실적(1 ~ 2 분기)",
        names.arg = dept,
        xlab = "부서", ylab = "영업 실적(억 원)",
        col = c("green", "orange"),
        legend.text = legend_lbl,
        ylim = c(0, 30),
        args.legend = list(x = "top", ncol = 2))

barplot(sales, main = "부서별 영업 실적(1 ~ 2 분기)",
        names.arg = dept,
        xlab = "부서", ylab = "영업 실적(억 원)",
        col = c("green", "orange"),
        legend.text = legend_lbl,
        xlim = c(0, 7),
        args.legend = list(x = "right"))

# 그룹형 바 차트
barplot(sales, main = "부서별 영업 실적(1 ~ 2 분기)",
        names.arg = dept,
        xlab = "부서", ylab = "영업 실적(억 원)",
        col = c("green", "orange"),
        legend.text = legend_lbl,
        xlim = c(0, 17),
        args.legend = list(x = "right"),
        beside = TRUE)