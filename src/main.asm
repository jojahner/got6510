; * = $0801                                       ; BASIC start address (#2049)
; !byte $0d,$08,$dc,$07,$9e,$20,$34,$39           ; BASIC loader to start at $c000...
; !byte $31,$35,$32,$00,$00,$00                   ; BASIC op-codes to execute 'SYS 49152'  (49152 = 0xc000)

; * = $c000

; *=$0800
; !byte $00,$0c,$08,$0a,$00,$9e,$32,$30,$36,$33,$00,$00,$00,$00
; *=$080f

!source "src/macros.asm"

*=$8000
.world !fill 1000, $00 ; 1 byte per cell, each bit represents a neighbour

*=$1000

.screen_pointer = $02    ; pointer to video RAM
.line_length    = $28    ; 40 characters per line
.row_count      = $19    ; 25 rows

start
    ; Set background and border to black
    lda #$00    ; Black
    sta $d020   ; Set border color
    sta $d021   ; Set background color
    ; Set cursor colot to green
    lda #$05   ; Green
    sta $0286   ; Set cursor color

    ; Clear the screen
    jsr $e544

    jsr init_screen
    ldx #$00
    jsr draw_world

    jmp *       ; loop forever

init_screen
    ; Set the the screen pointer to $0400
    lda #<$0400
    sta .screen_pointer
    lda #>$0400
    sta .screen_pointer+1
    rts

draw_world
    lda #$a0
    ldy #$00
draw_world_line
    sta (.screen_pointer), Y
    iny
    cpy #.line_length
    bne draw_world_line

    inx ; we are done with one line
    cpx #.row_count ; check if we are with with all rows (25 rows)
    beq draw_world_done
    ; we are not done increment pointer by 40 ($28)
    ; to draw the next line
    +add_word_in_memory .screen_pointer, .line_length

    jmp draw_world ; draw next line

draw_world_done:
    rts
