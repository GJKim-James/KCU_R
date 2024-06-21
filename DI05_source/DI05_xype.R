# X-Y 플로팅

# 플로팅 
women

height <- women$height
weight <- women$weight
plot(x = height, y = weight, xlab = "키 (단위 : 인치)", ylab = "몸무게 (단위 : 파운드)", main = "키와 몸무게의 변화")

# 플로팅 문자의 활용
plot(height, weight,
     xlab = "키", ylab = "몸무게",
     main = "키와 몸무게의 변화",
     pch = 23, col = "blue", bg = "yellow", cex = 1.5)

# 선의 유형
plot(height, weight, xlab = "키", ylab = "몸무게", type = "p")
# type: p, l, b, c, o, h, s, S, n
plot(height, weight, xlab = "키", ylab = "몸무게", type = "l", lty = 2, lwd = 3)

# 그래프 출력 범위
plot(height, weight,
     xlim = c(0, max(height)), ylim = c(0, max(weight)),
     xlab = "키", ylab = "몸무게",
     main = "키와 몸무게의 변화",
     pch = 23, col = "blue", bg = "yellow", cex = 1.5)
