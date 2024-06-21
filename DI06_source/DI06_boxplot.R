# 박스 플롯
mag <- quakes$mag
boxplot(mag,
        main = "지진 발생 강도의 분포",
        xlab = "지진", ylab = "지진 규모",
        col = "red")

# 박스 플롯 정보
min(mag)

max(mag)

median(mag)

Q <- quantile(mag)
Q

Q[4] - Q[2]  # 75% 값 - 25% 값

IQR(mag)  # 75% 값 - 25% 값

fence.upper <- Q[4] + 1.5 * IQR(mag)
fence.upper

fence.lower <- Q[2] - 1.5 * IQR(mag)
fence.lower

mag[mag > fence.upper]

max(mag[mag <= fence.upper])

mag[mag < fence.lower]
