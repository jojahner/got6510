
!macro add_word_in_memory .location, .value, .destination {
    clc
    lda .location        ; add the LSB
    adc #<.value
    sta .destination
    lda .location + 1    ; add the MSB
    adc #>.value
    sta .destination + 1
}

!macro substract_word_in_memory .location, .value, .destination {
    sec
    lda .location
    sbc #<.value
    sta .destination
    lda .location + 1
    sbc #>.value
    sta .destination + 1
}

!macro set_word .location, .value {
    lda #<.value
    sta .location
    lda #>.value
    sta .location + 1
}

!macro count_neighbour .location, .next_check, .counter {
    lda (.location), Y
    cmp #DEAD_CELL ; if the cell if dead we check the next one
    beq .next_check

    inc .counter
}
