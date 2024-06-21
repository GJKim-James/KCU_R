### if-else
a <- 5
if (a > 0) { print ('a is greater than 0') } else { print ('a is smaller than 0') }

a <- 10
if (a < 0) {
    print ('a is smaller than 0')
  } else if (a >= 0 & a <= 5){
    print ('a is between 0 and 5')
  } else {print ('a is greater than 5')}


##if (a < 0) {print ('a')}
##else {print ('b')}

if (a < 0) {print ('a')
} else {print ('b')}



## switch
inp <- 'a'  
switch(inp, 
       a = print ('inp is a'), 
       b = print ('inp is b'),
       c = print ('inp is c'),
       print ('inp is not a, b, c'))

#inp <- 1
#switch(inp,
#       1 = print (inp + 1))

inp <- 1
switch(inp,
       '1' = print (inp + 1),
       print ('none'))

inp <- 2
switch(inp, inp + 1, inp + 2, inp + 3, inp + 4)



##while

a <- 1
  #while (a < 4) {
  while (a <= 3) {
  print (paste ('This is iteration', a))
  a <- a + 1
}



##for
vector <- c('aaa', 'bbb', 'ccc')
for (i in vector) {
  print(i)
}

num <- c(1:3)
for (i in num) {
  print (i + 1)
}
