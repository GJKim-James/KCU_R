# 데이터 파일 읽기

# 데이터 세트 목록
data(package = "datasets")

# 데이터 세트 보기
quakes

head(quakes)

tail(quakes, n=10)

names(quakes)

dim(quakes)

str(quakes)

summary(quakes)
summary(quakes$mag)

iris

# 데이터 세트 저장하고 읽기
write.table(quakes, "quakest.csv", sep=",")
df <- read.csv("quakest.csv", header=T)
df

head(quakes)

x <- read.csv(file.choose(), header=T)
x

# 웹사이트의 데이터 파일 읽기
url <- "https://vincentarelbundock.github.io/Rdatasets/csv/datasets/Titanic.csv"
x <- read.csv(url)
x
