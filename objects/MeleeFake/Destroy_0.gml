repeat 16 {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(4) + 2)

        repeat speed {
            speed *= 0.9
        }
    }
}

event_inherited()

if GameCont.area == 105 {
    repeat 3 + irandom(3) {
        with instance_create(x, y, Feather) {
            sprite_index = sprLeaf
        }
    }
}