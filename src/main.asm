; * = $0801                                       ; BASIC start address (#2049)
; !byte $0d,$08,$dc,$07,$9e,$20,$34,$39           ; BASIC loader to start at $c000...
; !byte $31,$35,$32,$00,$00,$00                   ; BASIC op-codes to execute 'SYS 49152'  (49152 = 0xc000)

; * = $c000

; *=$0800
; !byte $00,$0c,$08,$0a,$00,$9e,$32,$30,$36,$33,$00,$00,$00,$00
; *=$080f

*=$1000


start
    ; Set background and border to black
    lda #$00    ; Black
    sta $d020   ; Set border color
    sta $d021   ; Set background color
    ; Set cursor colot to orange
    lda #$08    ; Orange
    sta $0286   ; Set cursor color

    ; Clear the screen
    jsr $e544
    jsr draw_world

    jmp *       ; loop forever


screen_pointer = $02

world !fill 1000, $00 ; 1 byte per cell, each bit represents a neighbour

draw_world
    ; init screen pointer
    lda #$00
    sta screen_pointer
    lda #$04
    sta screen_pointer+1

    lda #$FF ; $a0
    ldx #$00

_draw_world_loop
    ldy #$00

    ; test
    adc #$01
    and #$7F

_draw_world_line
    sta (screen_pointer), Y
    iny
    cpy #$e8
    bne _draw_world_line


    inc screen_pointer+1

    inx
    cpx #$04
    bne _draw_world_loop
debug:
    rts
