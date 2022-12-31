sprite_index = asset_get_index("sprDetail" + string(GameCont.area))

if !sprite_exists(sprite_index) {
    instance_destroy()
    exit
}

if (instance_nearest(x - 16, y - 16, Floor)).styleb && GameCont.area != 5 {
    instance_destroy()
    exit
}

image_speed = 0
image_xscale = choose(1, - 1)
image_index = irandom(image_number)