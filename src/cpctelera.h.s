.globl cpct_getScreenPtr_asm
;(2B DE) memory	Video memory pointer to the upper left box corner byte
;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
;(1B B ) height	Box height in bytes (>0)
    .globl cpct_drawSolidBox_asm
.globl cpct_waitVSYNC_asm
.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.globl cpct_setInterruptHandler_asm
.globl cpct_scanKeyboard_if_asm
.globl cpct_setVideoMemoryPage_asm
.globl cpct_drawCharM0_asm
.globl cpct_drawSprite_asm
.globl cpct_setPALColour_asm