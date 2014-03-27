
; use PIC 12F675
list     p=12f675
#include <p12f675.inc>

; Configuration word 

  __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 


  org 0x00
  goto main

main
  ; Power on D0
  bsf STATUS,RP0 ; enter bank 1
  movlw b'00001110'
  movwf TRISIO 

  bcf STATUS,RP0 ; enter bank 0
  movlw b'00010000'
  movwf GPIO  ; Light LED D0
  movlw b'00100000'
  movwf GPIO  ; Light LED D1

  bsf STATUS,RP0 ; bank 1
  movlw b'00101010'
  movwf TRISIO

  bcf STATUS,RP0 ; bank 0
  movlw b'00010000'
  movwf GPIO ; Light LED D2
  movlw b'00000100'
  movwf GPIO ; Light LED D3

  bsf STATUS,RP0 ; bank 1
  movlw b'00011010'
  movwf TRISIO

  bcf STATUS,RP0 ; bank 0
  movlw b'00100000'
  movwf GPIO ; Light LED D4
  movlw b'00000100'
  movwf GPIO ; Light LED D5

  bsf STATUS,RP0 ; bank 1
  movlw b'11111000'
  movwf TRISIO

  bcf STATUS,RP0 ; bank 0
  movlw b'00000100'
  movwf GPIO
  movlw b'00000010'
  movwf GPIO

  goto main

  end