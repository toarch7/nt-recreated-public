givekill = 1
scrDrop(20, 0)

event_inherited()

if GameCont.area == 105 {
    repeat 3 + irandom(3) {
        with instance_create(x, y, Feather) {
            sprite_index = sprLeaf
        }
    }
}