list     p=12f675
#include <p12f675.inc>

  global delay10_r

INT_VAR     UDATA_SHR
dc1         res 1  ; delay loop counter
dc2         res 1
dc3         res 1

  code

delay10_r
  banksel dc3
  movwf dc3
dly2
  movlw .13
  movwf dc2
  clrf dc1
dly1
  decfsz dc1,f
  goto dly1
  decfsz dc2,f
  goto dly1
  decfsz dc3,f
  goto dly2

  retlw 0

  end