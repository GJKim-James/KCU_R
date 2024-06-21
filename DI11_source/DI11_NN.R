## 보스톤 집값 예측
 
# 데이터 확인
install.packages("neuralnet")
install.packages("MASS")
library(neuralnet)
library(MASS)

# crim : 지역(town) 범죄 비율
# zn : 25,000ft2 당 거주자 비율
# chas : 찰스 강 지역에 대한 더미 변수(강의 경계에 위치하면 1, 그렇지 않으면 0)
# nox : 질소 산화물(NOx) 농도
# rad : 방사형 고속도로의 접근성 지수
# mediv : 주택 가격($1000 단위)
head(Boston)

# 분석 대상 데이터 할당(crim, zn, chas, nox, rad, mediv)
# 'crim, zn, chas, nox, rad' 은 입력, 'mediv' 은 출력으로 사용
data <- Boston[, c(1, 2, 4, 5, 9, 14)]
head(data)

# 결측치 확인(결과 : 없음)
# 1 : 행, 2 : 열
na <- apply(data, 2, is.na)
na
apply(na, 2, sum)

# 데이터 정규화
maxs <- apply(data, 2, max) 
maxs
mins <- apply(data, 2, min) 
mins

# 0과 1 사이의 값으로 표준화(스케일 조정)
data.scaled <- scale(data, center = mins, scale = maxs - mins)
data.scaled

# 학습용(80%)과 테스트용(20%) 데이터 분리 
n <- nrow(data.scaled)
n # 506

set.seed(1234) 
index <- sample(1:n, round(0.8 * n)) 
index

train <- as.data.frame(data.scaled[index, ])
head(train)

# train 데이터 이외 : -index
test <- as.data.frame(data.scaled[-index, ])
head(test)

nrow(train) + nrow(test) # 506

# 학습용 입출력 변수 할당
names.col <- colnames(train)
names.col

# 출력으로 사용될 부분
var.dependent <- names.col[6]
var.dependent

# 입력으로 사용될 부분
var.independent <- names.col[-6]
var.independent

f.var.independent <- paste(var.independent, collapse = " + ")
f.var.independent

f <- paste(var.dependent, "~", f.var.independent)
f

# 학습 및 모형 출력
# hidden : 은닉층
# 은닉층 첫 번째 층은 노드 3개, 은닉층 두 번째 층은 노드가 2개인 형태(은닉층은 총 2층)
model <- neuralnet(f, 
                   data = train,
                   hidden = c(3, 2),
                   linear.output = T)
plot(model)

# 테스트
predicted <- compute(model, test)
predicted$net.result

# 표준화된 값을 원래 값 형태로 복원
predicted.real <- predicted$net.result * (maxs[6] - mins[6]) + mins[6]
predicted.real

test.real <- test$medv * (maxs[6] - mins[6]) + mins[6]
test.real

# 실제값 대비 예측값 비교(분포)
plot(test.real,  predicted.real,
     xlim = c(0, 50), ylim = c(0, 50),
     main = "실제값 대비 예측값 분포",
     xlab = "실제값", ylab = "예측값",
     col = "red", 
     pch = 18, cex = 0.7)
abline(0, 1, col = "blue", lty = 2)

# 오차를 계산하는 함수(% 단위)
MAPE.model <- sum(abs(test.real - predicted.real)/test.real * 100) / length(test.real)
MAPE.model

