# Ch6. 사용자정의함수

addto = function(a){
  isum = 0
  for( i in 1:a){
    isum = isum + i
  }
  
  print(isum)
}

addto(5)
