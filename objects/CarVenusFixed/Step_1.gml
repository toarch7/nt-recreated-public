if lockstep_stop
	exit

if sprite_index != sprVenusCarFix {
    if sprite_index != spr_hurt
        sprite_index = spr_idle

    if sprite_index == spr_hurt {
        if image_index > 2 sprite_index = spr_idle
    }
}

speed = 0

if hp <= 0 instance_destroy()

if inframes inframes--