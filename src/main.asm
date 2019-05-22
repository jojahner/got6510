!cpu 6510

!source "src/macros.asm"

*=$8000
; world map: every byte is a cell with and every bit represents
;              0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39
.world !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;0
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;1
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;2
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20 ;3
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20 ;4
       !byte $20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;5
       !byte $20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$a0,$20,$a0,$a0,$20,$20,$20,$20,$a0,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;6
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;7
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$20,$20,$20,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;8
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;9
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;10
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;11
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;12
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;13
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;14
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;15
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;16
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;17
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;18
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;19
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;20
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;21
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;22
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;23
       !byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20 ;24
*=$1000

start
    ; Set background and border to black
    lda #$00    ; Black
    sta $d020   ; Set border color
    sta $d021   ; Set background color

    ; Set cursor color to green
    lda #$05    ; Green
    sta $0286   ; Set cursor color

    jsr $e544   ; clear screen

tick
    jsr draw_next_generation
    jsr caluclate_new_world_state
    jmp tick       ; loop forever

.next_generation      = $02 ; pointer to our back buffer
.current_generation   = $04 ; pointer to video RAM
.row_pointer          = $06

.neighbour_conter   !byte $00
.current_column     !byte $00

LINE_LENGTH            = $28 ; 40 characters per line
ROW_COUNT              = $19 ; 25 rows
SCREEN_MEMORY_LOCATION = $0400

ALIFE_CELL             = $a0
DEAD_CELL              = $20

caluclate_new_world_state
    ; iterate of the video memory line by line
    ; and count the neighbours for each cell
    +set_word .current_generation, SCREEN_MEMORY_LOCATION
    +set_word .next_generation, .world

    ; start with the first row
    ldx #$00
new_row
    ldy #$00

next_column
    lda #$00
    sta .neighbour_conter
    ; Y is the cell we want to count the neighbours for
    ; save current Y since we will modify it
    sty .current_column

check_top
    ; do we have neighbours to the top?
    cpx #$00
    beq check_left ; if not continue with left neighbours

    ; we have neighbours to the top
    ; we now have to set the row_ponter to current_generation - line_length bytes (40 colums)
    +substract_word_in_memory .current_generation, LINE_LENGTH, .row_pointer

check_top_left
    cpy #$00
    beq check_top_middle ; skip if there is no left

    dey
    lda (.row_pointer), Y
    cmp #DEAD_CELL
    beq check_top_left_done ; if the cell if dead we check the next one

    ; if the cell lives we increment the counter
    inc .neighbour_conter
check_top_left_done
    iny ; look at next cell
check_top_middle
    lda (.row_pointer), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_top_right

    ; if the cell lives we increment the counter
    inc .neighbour_conter

check_top_right
    cpy #LINE_LENGTH-1
    beq check_top_done; skip if there is no right

    iny

    lda (.row_pointer), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_top_done

    ; if the cell lives we increment the counter
    inc .neighbour_conter

check_top_done
    ; restore Y
    ldy .current_column

check_left
    cpy #$00
    beq check_right ; skip if there is no left

    dey
    lda (.current_generation), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_left_done

    inc .neighbour_conter

check_left_done
    iny

check_right
    cpy #LINE_LENGTH-1
    beq check_bottom ; skip if there is no right

    iny
    lda (.current_generation), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_right_done

    inc .neighbour_conter

check_right_done
    dey

check_bottom
    ; check if there is a bottom
    cpx #ROW_COUNT-1
    beq calculate_cell_life ; if not are done

    ; we have neighbours to the bottom
    ; we now have to set the row_ponter to current_generation + line_length bytes (40 colums)
    +add_word_in_memory .current_generation, LINE_LENGTH, .row_pointer
check_bottom_left
    cpy #$00
    beq check_bottom_middle ; skip if there is no left

    dey
    lda (.row_pointer), Y
    cmp #DEAD_CELL
    beq check_bottom_left_done ; if the cell if dead we check the next one

    ; if the cell lives we increment the counter
    inc .neighbour_conter
check_bottom_left_done
    iny ; look at next cell
check_bottom_middle
    lda (.row_pointer), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_bottom_right

    ; if the cell lives we increment the counter
    inc .neighbour_conter

check_bottom_right
    cpy #LINE_LENGTH-1
    beq check_bottom_done; skip if there is no right

    iny

    lda (.row_pointer), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq check_bottom_done

    ; if the cell lives we increment the counter
    inc .neighbour_conter

check_bottom_done
    ; restore Y
    ldy .current_column

calculate_cell_life
    ; calc if cell dies of lives
    lda (.current_generation), Y
    cmp #DEAD_CELL          ; check if current cell is dead
    beq foo

    ; if current cell lives
    lda .neighbour_conter
    cmp #$02
    beq current_cell_lives
foo
    lda .neighbour_conter
    cmp #$03
    beq current_cell_lives

    ; current cell if be dead next time
    lda #DEAD_CELL
    jmp set_cell_state

current_cell_lives
    lda #ALIFE_CELL

set_cell_state
    sta (.next_generation), y

    ; check if the at the end of a line
    cpy #LINE_LENGTH-1
    beq next_row

    iny ; next column
    jmp next_column

next_row
    ; check if the at the end of the row
    cpx #ROW_COUNT-1
    beq caluclate_new_world_state_done

    inx
    +add_word_in_memory .next_generation, LINE_LENGTH, .next_generation
    +add_word_in_memory .current_generation, LINE_LENGTH, .current_generation
    jmp new_row

caluclate_new_world_state_done
    rts

draw_next_generation
    ; Setup pointers
    +set_word .next_generation, .world
    +set_word .current_generation, SCREEN_MEMORY_LOCATION

    ldx #$00
copy_world
    ldy #$00
copy_world_line
    lda (.next_generation ), Y
    sta (.current_generation), Y
    iny
    cpy #LINE_LENGTH
    bne copy_world_line

    inx
    cpx #ROW_COUNT
    beq draw_next_generation_done

    +add_word_in_memory .next_generation, LINE_LENGTH, .next_generation
    +add_word_in_memory .current_generation, LINE_LENGTH, .current_generation

    jmp copy_world
draw_next_generation_done
    rts
