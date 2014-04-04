;
; Turn on LED D0 on the PICkit 1 board when the push button is down
;

; use PIC 12F675
list     p=12f675
#include <p12f675.inc>

; Configuration word 

  __CONFIG   _CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 

INT_VAR     UDATA_SHR   0x20   
W_TEMP      RES     1             ; variable used for context saving 
STATUS_TEMP RES     1             ; variable used for context saving
sGPIO       RES     1             ; GPIO shadow register

reset_vector code 0x0000  ; processor reset vector
  goto main

INT_VECTOR    CODE    0x0004  ; interrupt vector location
  MOVWF   W_TEMP        ; save off current W register contents
  MOVF    STATUS,w      ; move status register into W register
  MOVWF   STATUS_TEMP   ; save off contents of STATUS register

; isr code can go here or be located as a call subroutine elsewhere
  bcf STATUS,RP0 ; enter bank 0

  movf sGPIO,w      ; get shadow copy of GPIO
  xorlw b'00010000' ; toggle bit 4
  movwf sGPIO
  movwf GPIO

  bcf INTCON, T0IF      ; Clearing Timer0 interrupt flag


  MOVF    STATUS_TEMP,w ; retrieve copy of STATUS register
  MOVWF   STATUS        ; restore pre-isr STATUS register contents
  SWAPF   W_TEMP,f
  SWAPF   W_TEMP,w      ; restore pre-isr W register contents
  RETFIE                ; return from interrupt

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

  clrf sGPIO        ; clear shadow register

  ; Setup Timer0 Peripheral
  bsf STATUS,RP0  ; Bank 1
  bcf OPTION_REG, T0CS  ; Timer0 uses internal instruction clock
  bcf OPTION_REG, PSA   ; Prescaler is assigned to Timer0
  
  bcf STATUS,RP0  ; Bank 0
  bcf INTCON, T0IF      ; Clearing Timer0 interrupt flag
  bsf INTCON, T0IE      ; Enable Timer0 interrupt
  bsf INTCON, PEIE      ; Enable Peripheral interrupt
  bsf INTCON, GIE       ; Enable Global interrupt
  clrw
  movwf TMR0

  bcf STATUS,RP0 ; enter bank 0
  movlw b'00010000'
  movwf GPIO ; enable LED D0

  goto $

  end
