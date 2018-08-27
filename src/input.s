.area _DATA
    .include "cpctelera.h.s"
    .include "hero.h.s"
    .include "keyboard/keyboard.s"

.area _CODE
    updateInput::
        ld      hl, #Key_D
        call    cpct_isKeyPressed_asm
        cp      #0
        call    nz, moveRight
        
        ld      hl, #Key_A
        call    cpct_isKeyPressed_asm
        cp      #0
        call    nz, moveLeft
            
        ld      hl, #Key_Space
        call    cpct_isKeyPressed_asm
        cp      #0
        call    nz, jump

    ret