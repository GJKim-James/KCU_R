## 붓꽃 종의 분류(은닉층 노드 수의 변경)

# 데이터 확인
# install.packages("neuralnet")
library(neuralnet)

iris

data <- iris

# 결측치 확인(2는 열을 의미)
na <- apply(data, 2, is.na)
na

apply(na, 2, sum)

# 데이터 정규화
maxs <- apply(data[, 1:4], 2, max)
maxs

mins <- apply(data[, 1:4], 2, min)
mins

# 1열에서 4열(입력 데이터)까지 값을 0 ~ 1 사이의 값으로 표준화
data[, 1:4] <- scale(data[, 1:4], center = mins, scale = maxs - mins)
data[, 1:4]
data

# 출력 데이터 생성(setosa, virginica, versicolor 새로운 3개 열 추가)
# 종에 해당하면 1, 그렇지 않으면 0
data$setosa     <- ifelse(data$Species == "setosa", 1, 0)
data$virginica  <- ifelse(data$Species == "virginica", 1, 0)
data$versicolor <- ifelse(data$Species == "versicolor", 1, 0)
head(data)
tail(data)

# 학습용과 테스트용 데이터 분리
n <- nrow(data)

# 난수 생성(랜덤하게 뽑은 수가 매번 같은 결과)
set.seed(2000)
# 1부터 150까지 숫자 중 80%를 랜덤하게 뽑기
index <- sample(1:n, round(0.8 * n))
index

# 80%에 해당하는 120개의 훈련 데이터
train <- as.data.frame(data[index, ])
head(train)

# 나머지 30개의 테스트 데이터
test <- as.data.frame(data[-index, ])
head(test)

# 학습용 입출력 데이터
f.var.independent <- "Sepal.Length + Sepal.Width + Petal.Length + Petal.Width"
f.var.dependent   <- "setosa + versicolor + virginica"
# 인공신경망 입출력 노드 형식 : '출력 ~ 입력'
f <- paste(f.var.dependent, "~", f.var.independent)
f

# 학습 및 모형 출력(은닉층 8개 노드, 6개 노드 2층으로 구성)
nn <- neuralnet(f, data = train, hidden = c(8, 6), linear.output = F)
plot(nn)

# 테스트 
predicted <- compute(nn, test[, -5:-8])
predicted$net.result

# 가장 큰 값
idx <- max.col(predicted$net.result)
idx

# idx 값을 'setosa', 'versicolor', 'virginica'로 표현
species   <- c('setosa', 'versicolor', 'virginica')
predicted <- species[idx]
predicted

# 실제 값 대비 예측 값 비교(분포)
table(test$Species, predicted)

