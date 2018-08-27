.macro defineCharacter name, x, y, w, h
    name'_data:
        name'X:     .db x
        name'Y:     .db y
        name'W:     .db w
        name'H:     .db h
.endm
    .equ    hero_x, 0
    .equ    hero_y, 1
    .equ    hero_w, 2
    .equ    hero_h, 3