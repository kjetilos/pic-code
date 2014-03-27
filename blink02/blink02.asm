
; use PIC 12F675
list     p=12f675
#include <p12f675.inc>

; Configuration word 

  __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 

INT_VAR     UDATA_SHR   0x20
dc1         res 1  ; delay loop counter
dc2         res 1
dc3         res 1

reset_vector code 0x0000  ; processor reset vector
  goto main

main

; Calibrate internal oscillator according to the pic12f675 datasheet
; the location of the factory adjustment value is 0x3ff and they have stored
; an instruction 'retlw xx'

  bsf STATUS,RP0    ; set file register bank to 1 
  call 0x3ff        ; retrieve factory calibration value
  movwf OSCCAL      ; update register with factory cal value 
  bcf STATUS,RP0    ; set file register bank to 0

  bsf STATUS,RP0 ; enter bank 1
  movlw b'00001110'
  movwf TRISIO ; configure I/O

  bcf STATUS,RP0 ; enter bank 0

flash
  movlw b'00010000'
  movwf GPIO
  movlw .20
  call delay10

  movlw b'00000000'
  movwf GPIO
  movlw .80
  call delay10

  goto flash

delay10
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
