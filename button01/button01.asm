;
; Turn on LED D0 on the PICkit 1 board when the push button is down
;

; use PIC 12F675
list     p=12f675
#include <p12f675.inc>

; Configuration word 

  __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 

reset_vector code 0x0000  ; processor reset vector
  goto main

main

; Calibrate internal oscillator according to the pic12f675 datasheet
; the location of the factory adjustment value is 0x3ff and they have stored
; an instruction 'retlw xx'

  bsf STATUS,RP0    ; set file register bank to 1 
  call 0x3ff        ; retrieve factory calibration value
  movwf OSCCAL      ; update register with factory cal value 

  bsf STATUS,RP0 ; enter bank 1
  movlw b'00001110'
  movwf TRISIO ; configure I/O

  bcf STATUS,RP0 ; enter bank 0

loop
  clrw               ; clear working register
  btfss GPIO,3       ; test if button is pressed
  movlw b'00010000'  ; set GP4 on if GPIO pin 3 is set
  movwf GPIO

  goto loop

  end
