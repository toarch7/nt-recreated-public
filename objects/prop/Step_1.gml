if sprite_index != spr_hurt sprite_index = spr_idle

if sprite_index == spr_hurt && image_index > 2 {
    sprite_index = spr_idle
}

if !hp instance_destroy()

speed = 0

if inframes inframes--