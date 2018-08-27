.area _DATA
    .include "cpctelera.h.s"
    .include "macro.h.s"

    defineCharacter hero, 0, 80, 2, 8
    hero_state:     .db #-1
    hero_jump:      .db #-1
    jump_table:     .db #-3, #-2, #-1, #-1
                    .db #-1, #00, #00, #00
                    .db #01, #02, #02, #03
                    .db #0x80
.area _CODE

    drawHero::
        ;ToDo: Create a screen function
        ld      de, #0xC000
        call    heroPtrX
        ld      c, hero_x(ix)
        ld      b, hero_y(ix)

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0x0F    ;BOX COLOR
        ld      b, hero_h(ix)    
        ld      c, hero_w(ix)

        call    cpct_drawSolidBox_asm
    ret

    eraseHero::
        ld      de, #0xC000
        call    heroPtrX
        ld      c, hero_x(ix)
        ld      b, hero_y(ix)

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xF0    ;BOX COLOR
        ld      b, hero_h(ix)    
        ld      c, hero_w(ix)

        call    cpct_drawSolidBox_asm
    ret

    updateHero::
        ld      a, (hero_jump)
        cp      #-1
        ret     z
            ;JUMP
            ld      hl, #jump_table
            ld      c, a
            ld      b, #0
            add     hl, bc

            ld      a, (hl)
            cp      #0x80
            jr      z, end_jump

            ld      b, a
            call    heroPtrX
            ld      a, hero_y(ix)
            add     b
            ld      hero_y(ix), a

            ld      a, (hero_jump)
            inc     a
            ld      (hero_jump), a
    ret

    end_jump:
        ld      a, #-1
        ld      (hero_jump), a
    ret

    moveLeft::
        call    heroPtrX
        dec     hero_x(ix)
        ;CHECK COLLISIONS
    ret

    moveRight::
        call    heroPtrX
        inc     hero_x(ix)
        ;CHECK COLLISIONS
    ret

    jump::
        ld      a, (hero_jump)
        cp      #-1
        ret     nz
            ld      a, #0
            ld      (hero_jump), a
    ret

    heroPtrX::
        ld      ix, #hero_data
    ret

    heroPtrY::
        ld      iy, #hero_data
    ret