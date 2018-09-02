.area _DATA
    .include "cpctelera.h.s"
.area _CODE

    initVideoMemory::
        ld  hl, #0xC000
        ld  de, #0xC001
        ld  (hl), #0xFF
        ld  bc, #0x4000

        ldir
    ret