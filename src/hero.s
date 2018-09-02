.area _DATA
    .include "cpctelera.h.s"
    .include "macro.h.s"
    .include "map.h.s"
    
    .globl _sprite_Hero
    .globl _sprite_mask

    defineCharacter hero, 0, 80, 8, 32
    ;HERO STATES
    ;   0 -> On floor
    ;   1 -> Jumping
    ;   -1 -> Falling
    hero_state:     .db #0
    ;JUMP TABLE
    jump_index:     .db #0
    jump_table:     .db #-3, #-2, #-1, #-1
                    .db #-1, #00, #00, #00
                    ;.db #01, #02, #02, #03
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

        ld      a, #0x00  ;BOX COLOR
        ;ld 		hl, #_sprite_Hero
        ld      b, hero_h(ix)    
        ld      c, hero_w(ix)

        ;push    bc
        ;pop     ix
        ;
        ;ld      hl, #_sprite_mask
        ;ld      bc, #_sprite_Hero
        ;
        ;call    cpct_drawSpriteMaskedAlignedTable_asm
        ;call    cpct_drawSpriteMasked 
        ;call 	cpct_drawSprite_asm 
        call    cpct_drawSolidBox_asm
    ret

    eraseHero::
        ld      de, #0xC000
        call    heroPtrX
        ld      c, hero_x(ix)
        ld      b, hero_y(ix)

        call    cpct_getScreenPtr_asm
        ex      de, hl

        ld      a, #0xFF    ;BOX COLOR
        ld      b, hero_h(ix)    
        ld      c, hero_w(ix)

        call    cpct_drawSolidBox_asm
    ret

    updateHero::
        ld      a, (hero_state)
        cp      #0
        jr      z, onFloor
            dec     a
            jr      z, onJump
                jr      onFall    
    ;HERO STATE MACHINE
        ;WALKING ON FLOOR
        onFloor:
            call    heroPtrX
            ;CHECK FLOOR COLLISIONS
            call    checkMapFloor
            cp      #1
            ret     z
                ld      a, #-1
                ld      (hero_state), a
        ret

        ;JUMPING
        onJump:
            ld      hl, #jump_table
            ld      a, (jump_index)
            ld      c, a
            ld      b, #0
            add     hl, bc

            ld      a, (hl)
            cp      #0x80
            jr      z, endJump

            ld      b, a
            call    heroPtrX
            ld      a, hero_y(ix)
            add     b
            ld      hero_y(ix), a

            ld      a, (jump_index)
            inc     a
            ld      (jump_index), a
        ret

        ;FALLING
        onFall:
            call    heroPtrX
            ;CHECK FLOOR COLLISIONS
            call    checkMapFloor
            cp      #0
            jr      z, gravityPunch
                ld      a, #0
                ld      (hero_state), a
                ret
                ;GRAVITY PUNCH
                gravityPunch:
                    ld      a, hero_y(ix)
                    inc     a
                    ld      hero_y(ix), a
        ret
        
    endJump:
        ld      a, #0
        ld      (jump_index), a
        dec     a
        ld      (hero_state), a
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
        ld      a, (hero_state)
        cp      #0
        ret     nz
            ld      a, #1
            ld      (hero_state), a
    ret

    heroPtrX::
        ld      ix, #hero_data
    ret

    heroPtrY::
        ld      iy, #hero_data
    ret