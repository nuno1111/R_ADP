# Ch5. 조건문 반복문

# For Loop

a=c()
for( i in 1:9 ){
  a[i] = i * i
}
a

isum=0
for( i in 1:100 ){
  isum = isum + i
}
isum

# While Loop
x=1
while( x < 5 ){
  x = x + 1
  print(x)
}

# If-Else
statScore = 1:40 + 20
over70 = rep(0,40)

for( i in 1:40){
  if( statScore[i] >= 40){
    over70[i] = 1
  }
  else{
    over70[i] = 0
  }
}

over70

sum(over70)
