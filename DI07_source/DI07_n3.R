# install.packages("animation")
## 3의 배수 누적합
library(animation)

ani.options(interval = 0.1)
plot.new()

sum <- 0
for (i in 1:100) {
  if (i %% 3 == 0) {
    rect(0, 0, 1, 1, col = "yellow")
    
    sum <- sum + i
#    print(i)
    text(0.5, 0.5, sum, cex = 3, col = rgb(0, 0, 1, 1))
  }
  ani.pause()
}


## 5의 배수 출력 
library(animation)

ani.options(interval = 0.5)
plot.new()
 
for (i in 1:100) {
  if (i %% 5 == 0) {
    rect(0, 0, 1, 1, col = "yellow")
    text(0.5, 0.5, i, cex = 3, col = rgb(0, 0, 1, 1))
  }
  ani.pause()
}
