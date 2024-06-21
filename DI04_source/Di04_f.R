# 함수 정의와 호출
getTriangleArea <- function(w, h) {
  area <- w * h / 2
  return(area)
}

getTriangleArea(10, 5)



# 인치를 센티미터로 변환하는 함수의 정의와 호출
inch_to_cm <- function(inch) {
  cm <- inch * 2.54
  return(cm)
}

inch_to_cm(3)