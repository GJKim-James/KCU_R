# 산술 연산
2^3
2**3

# 벡터와 사칙 연산
x <- c(10, 20, 30, 40)
y <- c(2, 4, 6, 8)
z <- c(2, 4)

x+5

x+y

x+z

# 비교 연산자 
3 < 10

x <- c(10, 20, 30)
x <= 10

x[x>15]

# 비교 연산자 
x <- c(10, 20, 30)
any(x <= 10)

all(x <= 10)

# 논리 연산자 
x <- c(TRUE, TRUE, FALSE, FALSE)
y <- c(TRUE, FALSE, TRUE, FALSE)
x & y

x | y

xor(x, y)

# 결측지와 벌
x <- NULL
is.null(x)

y <- c(1, 2, 3, NA, 5)
y

z <- 10/0
z

u <- 0/0
u