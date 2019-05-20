
; Adds a word to location in memory
!macro add_word_in_memory .location, .value {
    clc
    lda .location      ; add the LSB
    adc #<.value
    sta .location
    lda .location+1    ; add the MSB
    adc #>.value
    sta .location+1
}
