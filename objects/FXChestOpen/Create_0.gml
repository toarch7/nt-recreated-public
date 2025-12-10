image_speed = 0.4

if GameCont.underwater {
    repeat irandom_range(12, 20) {
        with instance_create(x, y, Bubble) {
            motion_add(random_angle, random(3))
        }
    }
}