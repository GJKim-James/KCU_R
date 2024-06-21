# 이미지 읽기와 크기 변경
install.packages("magick")
library(magick)
#getwd()
#setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI07_source")
lion_bg <- image_read("lion_bg.png")
lion_1 <- image_read("lion_1.png")
lion_2 <- image_read("lion_2.png")

lion_bg <- image_scale(lion_bg,"600x300!")
lion_1 <- image_scale(lion_1,"100x50!")
lion_2 <- image_scale(lion_2,"100x50!")

print(lion_bg)
print(lion_1)
print(lion_2)

# 이미지 합성 테스트
img <- image_composite(lion_bg, lion_1, offset = "+100+200") # offset : 위치 설정
print(img)

# 이미지 이동
moving <- 0
x <- -100
y <- 150

while (TRUE) {
  if (x < 0)
    position <- paste(x, "+", y, sep = "")
  else
    position <- paste("+", x, "+", y, sep = "")
  if (moving %% 2 == 0) {
    img <- image_composite(lion_bg, lion_1, offset = position)
  } else {
    img <- image_composite(lion_bg, lion_2, offset = position)
  }
  
  print(img)
  
  Sys.sleep(0.3)
  
  if (x > 600)
    break
  
  moving <- moving + 1
  x <- x + 20
}
