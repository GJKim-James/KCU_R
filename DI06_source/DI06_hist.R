# 히스토그램

# 지진의 강도에 대한 히스토그램
quakes

mag <- quakes$mag
mag

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = rainbow(10))

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = rainbow(10),
     breaks = seq(4, 6.5, by = 0.5))

# 확률 밀도 곡선
hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "확률 밀도",
     col = rainbow(10),
     freq = FALSE)

lines(density(mag), lwd = 2)  # lwd : 선 두께
