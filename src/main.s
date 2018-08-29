.area _DATA
    .include "cpctelera.h.s"
    .include "hero.h.s"
    .include "input.h.s"
    .include "buffer.h.s"
    .include "map.h.s"
.area _CODE
    initConfig:
		call 	cpct_disableFirmware_asm	;disable firmware so we can set another options
		ld 		c, #0 						;load video mode 0 on screen
		call 	cpct_setVideoMode_asm

        ;ld 		hl, #_sprite_palette
		;ld 		de, #16
		;call 	cpct_setPalette_asm

        ld 		l, #16
		ld 		h, #0
		call 	cpct_setPALColour_asm
	ret

    isr:
        call    cpct_scanKeyboard_if_asm
    ret
    _main::
        call    initConfig
        call    initVideoMemory

        ld      hl, #isr
        call    cpct_setInterruptHandler_asm
        
        ; MAIN GAME

        mainBucle:
            call    eraseHero

            call    updateInput

            call    updateHero
            
            call    drawMap
            call    drawHero

            call 	cpct_waitVSYNC_asm

        jr      mainBucle
    ret