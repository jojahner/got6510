!cpu 6510

!source "src/macros.asm"

*=$8000
!source "src/worlds/pulse.asm"  ; include world into .world

*=$0801
    ; BASIC upstart  10 SYS 2064
    !byte $0d, $08, $0a, $00, $9e, $32, $30, $36, $34, $00, $00, $00, $00
*=$0810

start
    ; Set background and border to black
    lda #$00    ; Black
    sta $d020   ; Set border color
    sta $d021   ; Set background color

    ; Set cursor color to green
    lda #$05    ; Green
    sta $0286   ; Set cursor color

    jsr $e544   ; clear screen
    jsr setup_irq

    jmp *       ; loop forever

; variables
.world                = $8000
.next_generation      = $02 ; pointer to our back buffer
.current_generation   = $04 ; pointer to video RAM
.row_pointer          = $06

.neighbour_conter   !byte $00
.current_column     !byte $00

; constants
LINE_LENGTH            = $28 ; 40 characters per line
ROW_COUNT              = $19 ; 25 rows
SCREEN_MEMORY_LOCATION = $0400

ALIFE_CELL             = $a0
DEAD_CELL              = $20

caluclate_next_generation
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
    +count_neighbour .row_pointer, check_top_left_done, .neighbour_conter
check_top_left_done
    iny ; look at next cell
check_top_middle
    +count_neighbour .row_pointer, check_top_right, .neighbour_conter
check_top_right
    cpy #LINE_LENGTH-1
    beq check_top_done; skip if there is no right
    iny
    +count_neighbour .row_pointer, check_top_done, .neighbour_conter
check_top_done
    ldy .current_column
check_left
    cpy #$00
    beq check_right ; skip if there is no left
    dey
    +count_neighbour .current_generation, check_left_done, .neighbour_conter
check_left_done
    iny
check_right
    cpy #LINE_LENGTH-1
    beq check_bottom ; skip if there is no right
    iny
    +count_neighbour .current_generation, check_right_done, .neighbour_conter
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
    +count_neighbour .row_pointer, check_bottom_left_done, .neighbour_conter
check_bottom_left_done
    iny ; look at next cell
check_bottom_middle
    +count_neighbour .row_pointer, check_bottom_right, .neighbour_conter
check_bottom_right
    cpy #LINE_LENGTH-1
    beq check_bottom_done; skip if there is no right
    iny
    +count_neighbour .row_pointer, check_bottom_done, .neighbour_conter
check_bottom_done
    ldy .current_column
calculate_cell_life
    ; calc if cell dies of lives
    lda (.current_generation), Y
    cmp #DEAD_CELL          ; check if current cell is dead
    beq current_cell_dead
    ; if current cell lives
    lda .neighbour_conter
    cmp #$02
    beq current_cell_lives
current_cell_dead
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
    beq caluclate_next_generation_done
    inx
    +add_word_in_memory .next_generation, LINE_LENGTH, .next_generation
    +add_word_in_memory .current_generation, LINE_LENGTH, .current_generation
    jmp new_row
caluclate_next_generation_done
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

raster_irq
    dec $d019
    jsr draw_next_generation
    jsr caluclate_next_generation
    jmp $ea81

setup_irq
    sei                 ; disable interrupts

    lda #%01111111
    sta $dc0d          ; turn off timer interrupt
    lda $dc0d          ; cancel pending interrups

    lda #<raster_irq    ; set interrupt vector
    sta $0314
    lda #>raster_irq
    sta $0315

    lda #245           ; 245 = vblank
    sta $d012          ; set rasterline where we want the interrupt to fire

    lda $d011
    and #%01111111
    sta $d011          ; clear bit 7 (bit number 8 of raster line counter )

    lda $d01a
    ora #%00000001
    sta $d01a         ; enable Raster interrupt

    cli
    rts
