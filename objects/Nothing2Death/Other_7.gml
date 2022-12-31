if (sprite_index == sprNothingDeath) {
    BackCont.shake += 10
    image_speed = 0
    image_index = 6
    if instance_exists(BigGenerator) instance_create(x, (y + 8), SitDown)
}