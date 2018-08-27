.area _DATA
    .include "cpctelera.h.s"
.area _CODE
    drawMap::
        ;FIRST SEGMENT
        ld      de, #0xC000
        ld      c, #0
        ld      b, #108

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xFF    ;BOX COLOR
        ld      b, #4
        ld      c, #10

        call    cpct_drawSolidBox_asm
        ;SECOND
        ld      de, #0xC000
        ld      c, #10
        ld      b, #100

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xFF    ;BOX COLOR
        ld      b, #4
        ld      c, #40

        call    cpct_drawSolidBox_asm
        ;THIRD
        ld      de, #0xC000
        ld      c, #50
        ld      b, #118

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xFF    ;BOX COLOR
        ld      b, #4
        ld      c, #29

        call    cpct_drawSolidBox_asm
        
    ret

    checkMapFloor::
    ret