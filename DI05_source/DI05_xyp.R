# X-Y 플로팅 차트로 보는 지역별 미세먼지 현황

# 지역별 초미세먼지 농도 출력
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
lat  <- c(37.567933, 35.180002, 35.877052, 37.457730, 35.160331, 36.350573, 35.539865)
lon  <- c(126.978054, 129.074974, 128.600680, 126.702194, 126.851433, 127.384793, 129.311469)

plot(x = lon, y = lat,
     pch = 19, cex = pm25 * 0.3,
     col = rgb(1, 0, 1, 0.3),
     xlim = c(126, 130), ylim = c(35, 38),
     xlab = "경도", ylab = "위도")

text(x = lon, y = lat, labels = city)
