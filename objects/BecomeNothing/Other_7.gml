if sprite_index == sprNothingActivate {
    instance_create(x, y, Nothing)
    scrBossIntro(3)

    instance_destroy()
} else {
    image_index = 4
    image_speed = 0
}