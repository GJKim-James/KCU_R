#https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/data/mnist_csv.zip 을 다운받아 압축 풀면 train.csv, test.csv 파일이 생김

getwd()
setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI13_source")

## MNIST 데이터
# 데이터가 많아서 오래 걸림
mnist.train <- read.csv('train.csv')
mnist.test <- read.csv('test.csv')

dim(mnist.train)

head(colnames(mnist.train), 7)
tail(colnames(mnist.train), 7)
head(mnist.train[, 1:4], 9)

## MNIST 데이터 시각화(첫번째 컬럼은 'label'이기 때문에 2부터 시작)
#im <- matrix((mnist.train[4, 2:ncol(mnist.train)]), nrow = 28, ncol = 28)
im <- matrix((mnist.train[9, 2:ncol(mnist.train)]), nrow = 28, ncol = 28)
# 열 정보들을 숫자 형식으로 변환
im_numbers <- apply(im, 2, as.numeric)
image(1:28, 1:28, im_numbers, col = gray((0:255) / 255))

## MNIST 데이터 시각화 2
# 뒤집어진 사진 똑바로 해주고, 배경 하얀색, 글씨는 검정색으로 변환
im <- matrix(nrow = 28, ncol = 28)
j <- 1
for(i in 28:1){
  im[, i] <- (as.numeric(mnist.train[4, 2:ncol(mnist.train)]))[j:(j + 27)]
  j <- j+28
}
im_numbers <- apply(im, 2, as.numeric)
image(1:28, 1:28, im_numbers, col = gray((255:0) / 255))

## MNIST 데이터 시각화 함수
img <- function(d, row_index){
  # 행을 숫자 벡터로 변경(가로로 되어있는 784개의 픽셀 정보)
  r <- as.numeric(d[row_index, 2:785])
  # 행렬 선언 및 데이터 적재(가로로 되어있는 784개의 픽셀 정보를 행렬 형태로)
  im <- matrix(nrow = 28, ncol = 28)
  # 뒤집어서 표현
  j <- 1
  for(i in 28:1){
    im[, i] <- r[j:(j+27)]
    j <- j+28
  }  
  # 제목이 있는 이미지 출력
  image(x = 1:28, y = 1:28, z = im, col = gray((255:0) / 255), main = paste("Number :", d[row_index, 1]))
}

#img(mnist.train, 4)
img(mnist.train, 9)

## 여러 이미지 시각화
# par() : 그래프의 모양을 다양하게 조절할 수 있는 함수
# mfcol : 그래프를 열 우선 배치
# mar : 마진(margin, 간격)
par(mfcol = c(3, 3))
par(mar = c(1, 0, 3, 0), xaxs = 'i', yaxs = 'i')
for (idx in 1:9) { 
  img(mnist.train, idx)
}

par(mfcol = c(6, 6))
par(mar = c(1, 0, 3, 0), xaxs = 'i', yaxs = 'i')
for (idx in 1:36) { 
  img(mnist.train, idx)
}
# 화면 구분 초기화(default)
par(mfcol = c(1, 1))
par(mar = c(5.1, 4.1, 4.1, 2.1), xaxs = 'r', yaxs = 'r')
img(mnist.train, 9)


##################################################
## 다중 분류 데이터
set.seed(42)
# 'mnist.train' 데이터 중에서 6000개만 랜덤하게 뽑기
sample.2 <- sample(nrow(mnist.train), 6000)
# 6000개 중 5000개 학습 데이터
train.digits <- sample.2[1:5000]
# 6000개 중 1000개 테스트 데이터
test.digits <- sample.2[5001:6000]

# 입력 데이터(-1의 의미는 첫번째 열(label) 제외)
digits.X <- mnist.train[train.digits, -1]
# 첫번째 열은 결과(label, 어떤 숫자인지)
digits.y_n <- mnist.train[train.digits, 1]
# 'label'을 factor형으로 변환
mnist.train$label <- factor(mnist.train$label, levels = 0:9)
# 출력 데이터
digits.y <- mnist.train[train.digits, 1]

digits.test.X <- mnist.train[test.digits, -1]
digits.test.y <- mnist.train[test.digits, 1]

# 0 ~ 9 분포를 barplot으로 표현
barplot(table(digits.y), main = "Distribution of y values (train)")
barplot(table(digits.test.y), main = "Distribution of y values (test)")


## nnet을 이용한 데이터 분류 1
install.packages("caret")
install.packages("e1071")

library(nnet)
library(caret)
library(e1071)

# 랜덤하게 뽑되 seed 값 고정(항상 같은 값이 나오도록 함)
set.seed(42)
# 소요 시간 확인을 위한 설정
tic <- proc.time()

# 'nnet'은 은닉층이 1개인 신경망
# .size : 은닉층의 노드 수(네트워크 크기)
# .decay : 과대적합 방지(weight 급격하게 증가하는 것을 방지)
# maxit : 최대 반복
digits.m1 <- caret::train(digits.X, digits.y,
                          method = "nnet",
                          tuneGrid = expand.grid(
                            .size = c(5),
                            .decay = c(0.1)),
                          trControl = trainControl(method = "none"),
                          MaxNWts = 10000,
                          maxit = 100)

# 소요 시간 출력
print(proc.time() - tic)
# 사용자  시스템 elapsed 
# 44.72    0.22   45.25

## nnet을 이용한 데이터 예측 1
digits.yhat1 <- predict(digits.m1, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat1 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 50.60%"
# 0 ~ 9 분포를 barplot으로 표현
barplot(table(digits.yhat1), main = "Distribution of y values (model 1)")
table(digits.test.y, digits.yhat1)
caret::confusionMatrix(xtabs(~digits.yhat1 + digits.test.y))


## nnet을 이용한 데이터 분류 2(은닉 노드 증가시킴, 학습 시간은 증가)
set.seed(42)
tic <- proc.time()
digits.m2 <- caret::train(digits.X, digits.y,
                          method = "nnet",
                          tuneGrid = expand.grid(
                            .size = c(10),
                            .decay = 0.1
                          ),
                          trControl = trainControl(method = "none"),
                          MaxNWts = 50000,
                          maxit = 100)
print(proc.time() - tic)
# 사용자  시스템 elapsed 
# 116.88    0.25  117.68

## nnet을 이용한 데이터 예측 2
digits.yhat2 <- predict(digits.m2, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat2 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 55.80%"
barplot(table(digits.yhat2), main = "Distribution of y values (model 2)")
table(digits.test.y, digits.yhat2)
caret::confusionMatrix(xtabs(~digits.yhat2 + digits.test.y))


## nnet을 이용한 데이터 분류 3
set.seed(42)
tic <- proc.time()
digits.m3 <- caret::train(digits.X, digits.y,
                          method = "nnet",
                          tuneGrid = expand.grid(
                            .size = c(40),
                            .decay = 0.1
                          ),
                          trControl = trainControl(method = "none"),
                          MaxNWts = 50000,
                          maxit = 100)
print(proc.time() - tic)
#    user  system elapsed 
# 2164.09    1.25 2168.64 

## nnet을 이용한 데이터 예측 3
digits.yhat3 <- predict(digits.m3, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat3 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 83.70%"
barplot(table(digits.yhat3), main = "Distribution of y values (model 3)")
table(digits.test.y, digits.yhat3)
caret::confusionMatrix(xtabs(~digits.yhat3 + digits.test.y))


#####################
## RSNNS를 이용한 데이터 분류 (Stuttgart Neural Networks Simulator)
install.packages("RSNNS")
library(RSNNS)

# one-hot encoding
head(decodeClassLabels(digits.y))

set.seed(42)
tic <- proc.time()
# mlp : Multi Layer Perceptron
digits.m4 <- mlp(as.matrix(digits.X),
                 decodeClassLabels(digits.y),
                 size = 40,
                 learnFunc = "Rprop",
                 shufflePatterns = FALSE,
                 maxit = 80)
print(proc.time() - tic)
# 사용자  시스템 elapsed 
# 122.78    0.40  123.83


## RSNNS를 이용한 데이터 예측
digits.yhat4 <- predict(digits.m4, newdata = digits.test.X)
digits.yhat4 <- encodeClassLabels(digits.yhat4)
# 'digits.yhat4' 데이터를 보면 1 ~ 10만 나옴. 0 ~ 9로 나와야 정상(그래서 -1)
accuracy <- 100.0 * sum(I(digits.yhat4 - 1) == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 82.30%"
barplot(table(digits.yhat4), main = "Distribution of y values (model 4)")
table(digits.test.y, digits.yhat4)
