install.packages("imager")
library(imager)

getwd()
setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI05_source")

img_path <- "pinwheel.png"
img <- load.image(img_path)
plot(img)

img <- resize(img, size_x = 400L, size_y = 400L)
plot(img, xlim = c(0, 400), ylim = c(0, 400))

angle <- 0
while(TRUE) {
  angle <- angle + 20
  imrotate(img, angle, cx = 200, cy = 200) %>%  
    plot(axes = FALSE) # 축은 안보이게 설정
  Sys.sleep(0.2)
}