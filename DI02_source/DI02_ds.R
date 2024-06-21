#대입연산
x<-y=100
x
y
x=y<-200
x
y
x=y=300
x
y
x<-(y=100)
x
y

#데이터 타입
a="홍길동"
a
b='홍길동'
b
c=3
c
d=3.34
d
e=2+3i
e
f=TRUE
f
g=NULL
g
h=0/0
h

#변수이름 
v_n.1 <- 10          # 가능
.v_.1 <- 10          # 가능
v_1 <-10             # 가능
.1v.n <- 10          # 불가능
_v <- 10             # 불가능
%v.n<- 10            # 불가능
1v.n <- 10           # 불가능


#데이터 타입 확인 
class(e)
str(e)
typeof(e)
is.numeric(e)
is.complex(e)

#데이터 타입 변환 
#데이터 타입을 확인하고 싶은 경우 class(변수명) 을 사용한다.

z<-100
class(z) 
z<- as.integer(z) 
class(z) 

z<- as.character(z) 
z
class(z) 

z<- as.numeric(z) 
z
class(z) 
