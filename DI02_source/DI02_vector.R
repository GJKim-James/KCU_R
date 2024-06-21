# 벡터 만들기
score <- 70
score

score <- c(70, 85, 90)
score
print(score)

score[4] <- 100
score[3] <- 95
score

name <- c("알라딘", "자스민", "지니")
name

# 연속적인 값들의 벡터 만들기
x <- seq(1, 10, by=3)
x

x <- 1:10
x

x <- 10:1
x
x <- seq(1, 10, length.out=7)
x

# 반복적인 값들의 벡터 만들기
x <- c(1, 2, 3)
y <- rep(x, times=2)

y
y <- rep(x, each=2)
y


