#https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/data/mnist_csv.zip을 다운받아 압축 풀면 train.csv, test.csv 파일이 생김

getwd()
setwd("C:/Users/User/Desktop/숭실사이버대학교/3학년 2학기/데이터과학 입문(이현진)/DI14_source")

## MNIST 데이터
# 데이터가 많아서 오래 걸림
mnist.train <- read.csv('train.csv')
#mnist.test <- read.csv('test.csv')

#dim(mnist.train)

#head(colnames(mnist.train), 7)
#tail(colnames(mnist.train), 7)
#head(mnist.train[,1:4],9)

## MNIST 데이터 시각화 함수
img <- function(d, row_index){
  # 행을 숫자 벡터로 변경
  r <- as.numeric(d[row_index, 2:785])
  # 행렬 선언 및 데이터 적재
  im <- matrix(nrow = 28, ncol = 28)
  j <- 1
  for(i in 28:1){
    im[, i] <- r[j:(j+27)]
    j <- j + 28
  }  
  # 제목이 있는 이미지 출력
  image(x = 1:28, y = 1:28, z = im, col = gray((255:0) / 255), main = paste("Number:", d[row_index, 1]))
}

#img(mnist.train, 4)
img(mnist.train, 9)

## 여러 이미지 시각화
par(mfcol = c(3, 3))
par(mar = c(1, 0, 3, 0), xaxs = 'i', yaxs = 'i')
for (idx in 1:9) { 
  img(mnist.train, idx)
}

# 화면 구분 초기화(default)
par(mfcol = c(1, 1))
par(mar = c(5.1, 4.1, 4.1, 2.1), xaxs = 'r', yaxs = 'r')
img(mnist.train, 9)


##############################
## 다중 분류 데이터
set.seed(42)
sample.2 <- sample(nrow(mnist.train), 6000)
train.digits <- sample.2[1:5000]
test.digits <- sample.2[5001:6000]

digits.X <- mnist.train[train.digits, -1]
digits.y_n <- mnist.train[train.digits, 1]
mnist.train$label <- factor(mnist.train$label, levels = 0:9)
digits.y <- mnist.train[train.digits, 1]

digits.test.X <- mnist.train[test.digits, -1]
digits.test.y <- mnist.train[test.digits, 1]

barplot(table(digits.y), main = "Distribution of y values (train)")
barplot(table(digits.test.y), main = "Distribution of y values (test)")

## nnet을 이용한 데이터 분류 1
#install.packages("caret")
#install.packages("e1071")

library(caret)
library(e1071)

set.seed(42)
tic <- proc.time()

digits.m1 <- caret::train(digits.X, digits.y,
                          method = "nnet",
                          tuneGrid = expand.grid(
                            .size = c(5),
                            .decay = c(0.1)),
                          trControl = trainControl(method = "none"),
                          MaxNWts = 10000,
                          maxit = 100)
print(proc.time() - tic)
#    사용자  시스템 elapsed 
#     39.19    0.31   39.71

## nnet을 이용한 데이터 예측 1
digits.yhat1 <- predict(digits.m1, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat1 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 43.10%"
barplot(table(digits.yhat1), main = "Distribution of y values (model 1)")
table(digits.test.y, digits.yhat1)
caret::confusionMatrix(xtabs(~digits.yhat1 + digits.test.y))


## nnet을 이용한 데이터 분류 2
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
#   사용자  시스템 elapsed 
#   115.28    0.52  116.38

## nnet을 이용한 데이터 예측 2
digits.yhat2 <- predict(digits.m2, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat2 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 67.80%"
barplot(table(digits.yhat2), main = "Distribution of y values (model 2)")
table(digits.test.y, digits.yhat2)
caret::confusionMatrix(xtabs(~digits.yhat2 + digits.test.y))


## nnet을 이용한 데이터 분류 3
# 시간 엄청 오래 걸림
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
#    사용자  시스템 elapsed 
#   6969.52   30.40 7395.72

## nnet을 이용한 데이터 예측 3
digits.yhat3 <- predict(digits.m3, newdata = digits.test.X)
accuracy <- 100.0 * sum(digits.yhat3 == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 82.80%"
barplot(table(digits.yhat3), main = "Distribution of y values (model 3)")
table(digits.test.y, digits.yhat3)
caret::confusionMatrix(xtabs(~digits.yhat3 + digits.test.y))





##############################
## RSNNS를 이용한 데이터 분류 (Stuttgart Neural Networks Simulator)
#install.packages("RSNNS")
library(RSNNS)

# one-hot encoding
head(decodeClassLabels(digits.y))

tic <- proc.time()
digits.m4 <- mlp(as.matrix(digits.X),
                 decodeClassLabels(digits.y),
                 size = 40,
                 learnFunc = "Rprop",
                 shufflePatterns = FALSE,
                 maxit = 80)
print(proc.time() - tic)
#   사용자  시스템 elapsed 
#   120.95    1.12  123.14


## RSNNS를 이용한 데이터 예측
digits.yhat4 <- predict(digits.m4, newdata = digits.test.X)
digits.yhat4 <- encodeClassLabels(digits.yhat4)
accuracy <- 100.0 * sum(I(digits.yhat4 - 1) == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy))
# [1] "accuracy = 82.10%"
barplot(table(digits.yhat4), main = "Distribution of y values (model 4)")
table(digits.test.y, digits.yhat4)



############################################################
## 실환경에서 데이터 예측 방법 1
digits.yhat4_b <- predict(digits.m4, newdata = digits.test.X)
head(round(digits.yhat4_b, 2))
head(digits.test.y)
# WTA : Winner Take All(가장 큰 값으로 판단)
digits.yhat4_b_1 <- encodeClassLabels(digits.yhat4_b, method = "WTA", l = 0, h = 0)

table(digits.yhat4_b_1)
#   1   2   3   4   5   6   7   8   9  10 
# 103 124 100 102  87  83 105 104 100  92

table(digits.test.y)
#  0   1   2   3   4   5   6   7   8   9 
# 99 121  92 101  85 108 100 105  95  94

accuracy_b_1 <- 100.0 * sum(I(digits.yhat4_b_1 - 1) == digits.test.y) / length(digits.test.y)
print(sprintf("accuracy = %1.2f%%", accuracy_b_1))
# [1] "accuracy = 82.10%"

## 실환경에서 데이터 예측 방법 2
# 0.5가 넘지 않으면 모르는 것으로 판단
digits.yhat4_b_2 <- encodeClassLabels(digits.yhat4_b, method = "WTA", h = 0.5)

table(digits.yhat4_b_2)
#   0   1   2   3   4   5   6   7   8   9  10 
# 155  94 116  91  83  74  62  91  93  71  70

accuracy_b_2 <- 100.0 * sum(I(digits.yhat4_b_2 - 1) == digits.test.y) / (length(digits.test.y) - length(which(digits.yhat4_b_2 == 0)))
print(sprintf("accuracy = %1.2f%%", accuracy_b_2))
# [1] "accuracy = 89.35%"

unknown_b_2 <- 100.0 * length(which(digits.yhat4_b_2 == 0)) / length(digits.yhat4_b_2)
print(sprintf("unknown = %1.2f%%", unknown_b_2))
# [1] "unknown = 15.50%"

### 비교하기 위한 코드 
head(round(digits.yhat4_b, 2), 20)
digits.yhat4_b_2[1:20]


## 실환경에서 데이터 예측 방법 3
# 402040 : 판단되는 노드는 h 이상, 판단되지 않는 노드는 l 이하
digits.yhat4_b_3 <- encodeClassLabels(digits.yhat4_b, method = "402040", l = 0.4, h = 0.6)
table(digits.yhat4_b_3)
#   0   1   2   3   4   5   6   7   8   9  10 
# 259  87 115  79  70  61  48  85  85  53  58

### 비교하기 위한 코드 
head(round(digits.yhat4_b, 2), 20)
digits.yhat4_b_3[1:20]

accuracy_b_3 <- 100.0 * sum(I(digits.yhat4_b_3 - 1) == digits.test.y) / (length(digits.test.y) - length(which(digits.yhat4_b_3 == 0)))
print(sprintf("accuracy = %1.2f%%", accuracy_b_3))
# [1] "accuracy = 92.04%"

unknown_b_3 <- 100.0 * length(which(digits.yhat4_b_3 == 0)) / length(digits.yhat4_b_3)
print(sprintf("unknown = %1.2f%%", unknown_b_3))
# [1] "unknown = 25.90%"





## 과적합 (Overfitting)
# 학습 데이터에 대한 인식률
digits.yhat4.train <- predict(digits.m4)
digits.yhat4.train <- encodeClassLabels(digits.yhat4.train)
accuracy <- 100.0 * sum(I(digits.yhat4.train - 1) == digits.y) / length(digits.y)
print(sprintf("accuracy = %1.2f%%",accuracy))
# [1] "accuracy = 85.70%" : 학습 데이터

# 모든 모델의 학습 데이터에 대한 인식률
digits.yhat1.train <- predict(digits.m1)
digits.yhat2.train <- predict(digits.m2)
digits.yhat3.train <- predict(digits.m3)
digits.yhat4.train <- predict(digits.m4)
digits.yhat4.train <- encodeClassLabels(digits.yhat4.train)

# 학습 데이터 인식률과 테스트 데이터 인식률을 결합
measures <- c("AccuracyNull", "Accuracy", "AccuracyLower", "AccuracyUpper")
n5.insample <- caret::confusionMatrix(xtabs(~digits.y + digits.yhat1.train))
n5.outsample <- caret::confusionMatrix(xtabs(~digits.test.y + digits.yhat1))
n10.insample <- caret::confusionMatrix(xtabs(~digits.y + digits.yhat2.train))
n10.outsample <- caret::confusionMatrix(xtabs(~digits.test.y + digits.yhat2))
n40.insample <- caret::confusionMatrix(xtabs(~digits.y + digits.yhat3.train))
n40.outsample <- caret::confusionMatrix(xtabs(~digits.test.y + digits.yhat3))
n40b.insample <- caret::confusionMatrix(xtabs(~digits.y + I(digits.yhat4.train - 1)))
n40b.outsample <- caret::confusionMatrix(xtabs(~digits.test.y + I(digits.yhat4 - 1)))
# In : 학습 데이터, Out : 테스트 데이터
shrinkage <- rbind(cbind(Size = 5, Sample = "In",
                         as.data.frame(t(n5.insample$overall[measures]))),
                   cbind(Size = 5, Sample = "Out",
                         as.data.frame(t(n5.outsample$overall[measures]))),
                   cbind(Size = 10, Sample = "In",
                         as.data.frame(t(n10.insample$overall[measures]))),
                   cbind(Size = 10, Sample = "Out",
                         as.data.frame(t(n10.outsample$overall[measures]))),
                   cbind(Size = 40, Sample = "In",
                         as.data.frame(t(n40.insample$overall[measures]))),
                   cbind(Size = 40, Sample = "Out",
                         as.data.frame(t(n40.outsample$overall[measures]))),
                   cbind(Size = 40, Sample = "In",
                         as.data.frame(t(n40b.insample$overall[measures]))),
                   cbind(Size = 40, Sample = "Out",
                         as.data.frame(t(n40b.outsample$overall[measures])))
)
shrinkage$Pkg <- rep(c("nnet", "RSNNS"), c(6, 2))

# 그림으로 나타내기
dodge <- position_dodge(width = 0.4)
ggplot(shrinkage, aes(interaction(Size, Pkg, sep = " : "), Accuracy,
                      ymin = AccuracyLower, ymax = AccuracyUpper,
                      shape = Sample, linetype = Sample)) +
  geom_point(size = 2.5, position = dodge) +
  geom_errorbar(width = .25, position = dodge) +
  xlab("") + ylab("Accuracy + 95% CI") +
  theme_classic() +
  theme(legend.key.size = unit(1, "cm"), legend.position = c(.8, .2))
