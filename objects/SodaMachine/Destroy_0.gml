event_inherited()

repeat(20) {
    with instance_create(x + random(8) - 4, y + random(16), Shell) {
        motion_add(random_angle, random(4) + 3)
        sprite_index = sprSodaCan
        image_index = random(3)
        image_speed = 0
    }
}