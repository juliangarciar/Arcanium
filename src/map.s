.area _DATA
    .include "cpctelera.h.s"
    .include "macro.h.s"
    defineHorizontalFloor floor0, 0, 108, 10, 4, 0
    defineHorizontalFloor floor1, 10, 100, 40, 4, 0
    defineHorizontalFloor floor2, 50, 118, 29, 4, 1

.area _CODE
    drawMap::
        ;FIRST SEGMENT
        ld      iy, #floor0_H_data
        ld      de, #0xC000
        ld      c, horizontal_floor_x(iy)
        ld      b, horizontal_floor_y(iy)

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xFF    ;BOX COLOR
        ld      b, horizontal_floor_h(iy)
        ld      c, horizontal_floor_w(iy)

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

    ;COLLISION WITH MAP FLOOR
    ;Breaks A
    ;   0 -> No collision
    ;   1 -> Collision
    checkMapFloor::
        ld      iy, #floor0_H_data
        checkUpperY:
            ld      c, horizontal_floor_y(iy)
            ld      b, hero_y(ix)
            ld      a, hero_h(ix)
            add     a, b
            sub     c    
            jp      m, noCollision   
            checkBottomY:
                ld      c, hero_y(ix)
                ld      b, horizontal_floor_y(iy)
                ld      a, horizontal_floor_h(iy)
                add     a, b
                sub     c
                jp      m, noCollision
                checkLeftX:
                    ld      c, horizontal_floor_x(iy)
                    ld      b, hero_x(ix)
                    ld      a, hero_w(ix)
                    add     a, b
                    sub     c
                    jp      m, noCollision
                    checkRightX:
                        ld      c, hero_x(ix)
                        ld      b, horizontal_floor_x(iy)
                        ld      a, horizontal_floor_w(iy)
                        add     a, b
                        sub     c
                        jp      m, noCollision
        yesCollision:
            ld      a, #1
            ret
        noCollision:
            ld      a, #0
    ret