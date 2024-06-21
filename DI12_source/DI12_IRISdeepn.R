## 붓꽃의 분류

install.packages("deepnet")      # nn.train(); 학습, nn.predict(); 예측
install.packages("data.table")   # as.data.table(); 테이블 구조로 변환
install.packages("mltools")      # one_hot(); 원-핫 인코딩

library(deepnet)
library(data.table)
library(mltools)

# 붓꽃 데이터
iris

# 정규화(0 ~ 1)
maxs <- apply(iris[, 1:4], 2, max)
maxs
mins <- apply(iris[, 1:4], 2, min)
mins
data <- scale(iris[, 1:4], center = mins, scale = maxs - mins)
data

data <- cbind(data, iris[, 5])
data

# 학습 데이터용 표본 추출을 위한 행 번호  
n <- nrow(data)
set.seed(1234)
idx <- sample(1:n, round(0.8 * n, 0))
idx

# 학습 및 테스트 데이터 
Xtrain <- data[idx,  1:4]  # 입력
Ytrain <- data[idx,  5]    # 출력
Xtest  <- data[-idx, 1:4]  # 입력
Ytest  <- data[-idx, 5]    # 출력

# one-hot encoding 
Z <- as.factor(Ytrain)
Z <- one_hot(as.data.table(Z))
Ytrain.labels <- as.matrix(Z)
Ytrain.labels[1,]
Ytrain.labels

# 학습 시작 시간 
start <- Sys.time()

# 학습(활성화 함수 : 시그모이드, 출력 계산 : softmax 기법, 500번 학습)
nn <- nn.train(x = Xtrain,
               y = Ytrain.labels,
               hidden = c(4, 4), activationfun = "sigm",
               #hidden=c(4, 8), activationfun = "sigm",
               output = "softmax",
               numepochs = 500)

# 학습 종료 시간 
end <- Sys.time()

# 학습 경과 시간
time.elapsed <- difftime(end, start, units = "mins")
time.elapsed

# 테스트
predicted <- nn.predict(nn, Xtest)
predicted

# 각 행에서 가장 큰 값의 열 위치 추출
predicted.ind <- apply(predicted, 1, which.max)

predicted.labels <- predicted.ind
predicted.labels

# 교차표
t <- table(Ytest, predicted.labels)
t
 
# 정확도
sum(diag(t)) / sum(t) * 100