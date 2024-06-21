# 요인 만들기 
gender <- c("남", "여", "남")
gender

gender.factor <- factor(gender)
gender.factor


# 색상 만들기 
cname <- c("빨강", "주황", "노랑", "초록", "파랑", "남색", "보라", "빨강")
cname

cname.factor <- factor(cname)
cname.factor

class(cname.factor)
typeof(cname.factor)
str(cname.factor)


# 배열과 행렬
# 배열 만들기
x <- c(70, 80, 95)
arr <- array(x)
arr

z <- 1:6
arr <- array(z, dim=c(2,3))
arr


# 행과 열 이름 설정 및 데이터 수정
name  <- list(c("국어", "음악"), c("알라딘", "자스민", "지니"))
#name  <- list(c("국어", "음악"), c(1,2,3))
score <- c(70, 80, 85, 90, 90, 75)
arr <- array(score, dim=c(2,3), dimnames=name)
arr

arr[2,3] <- 77
arr[2,3]

arr[1,]

arr[,2]

# 행렬
name <- list(c("1행", "2행"), c("1열", "2열", "3열"))
x <- 1:6
mtx <- matrix(x, nrow=2, )
mtx

mtx <- matrix(x, nrow=2, dimnames=name, byrow=TRUE)
mtx

y <- c(7, 8, 9)
mtx <- rbind(mtx, y)
rownames(mtx)[3] <- "3행"
mtx

z <- c(10, 11, 12)
mtx <- cbind(mtx, z)
colnames(mtx)[4] <- "4열"
mtx
