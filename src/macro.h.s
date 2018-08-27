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

.macro defineHorizontalFloor name, x, y, w, h, l
    name'_H_data:
        name'X:     .db x
        name'Y:     .db y
        name'W:     .db w
        name'H:     .db h
        name'L:     .db l
.endm
    .equ    horizontal_floor_x, 0
    .equ    horizontal_floor_y, 1
    .equ    horizontal_floor_w, 2
    .equ    horizontal_floor_h, 3
    .equ    horizontal_floor_l, 4

