; *=$0800
; !byte $00,$0c,$08,$0a,$00,$9e,$32,$30,$36,$33,$00,$00,$00,$00
; *=$080f

*=$1000

start
    ; Make screen black and text white
    lda #$00
    sta $d020
    sta $d021
    lda #$01
    sta $0286
    ; Clear the screen and jump to draw routine
    jsr $e544
    jsr draw_text
    jmp *

message
    !scr "              hello world!!             "	; 40 cols of text

draw_text
    ldx #$00         ; init X-Register with $00
loop_text
    lda message,x    ; read characters from message text...
    sta $0590,x      ; ...and place it into screen screen memory
    inx 				; increment to next character
    cpx #$28         ; false if != 40
    bne loop_text    ; loop if false
    rts
