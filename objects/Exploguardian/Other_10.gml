if sprite_index != spr_hurt && sprite_index != spr_chrg && sprite_index != spr_fire {
    sprite_index = spr_idle
}

if sprite_index == spr_hurt or sprite_index == spr_chrg or sprite_index == spr_fire {
    if image_index >= sprite_get_number(sprite_index) - 1 {
        if sprite_index == sprExploguardianFire {
            spr_idle = sprExploguardianIdle
            spr_hurt = sprExploguardianHurt
            charge = 0
        }

        sprite_index = spr_idle
    }
}

if hp <= 0 instance_destroy()

if inframes inframes--

if hspeed > 0 right = 1
else if hspeed < 0 right = -1

if walk && !charge && sprite_index != spr_hurt {
    motion_add(direction, .5)
}

if charge {
    speed = 0
}

if speed > 2.5 speed = 2.5