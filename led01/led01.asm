
; use PIC 12F675
list     p=12f675
#include <p12f675.inc>

; Configuration word 

  __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 


  org 0x00
  goto main

main
  bsf STATUS,RP0 ; enter bank 1
  movlw b'11001110'
  movwf TRISIO ; configure I/O

  bcf STATUS,RP0 ; enter bank 0
  movlw b'00010000'
  movwf GPIO  ; power on desired LED D0 = 0 1 Z Z
  goto $       ; loop forever

  end