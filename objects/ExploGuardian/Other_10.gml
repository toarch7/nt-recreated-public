if sprite_index != spr_hurt && sprite_index != spr_chrg && sprite_index != spr_fire {
    sprite_index = spr_idle
}

if sprite_index == spr_hurt || sprite_index == spr_chrg || sprite_index == spr_fire {
    if image_index >= sprite_get_number(sprite_index) - 1 {
        if sprite_index == sprExploGuardianFire {
            spr_idle = sprExploGuardianIdle
            spr_hurt = sprExploGuardianHurt
            charge = fals
        }

        sprite_index = spr_idle
    }
}

if (hspeed != 0) right = sign(hspeed)

if walk && !charge && sprite_index != spr_hurt {
    motion_add(direction, 0.5)
}

if (charge) {
	speed = 0
}
else if speed > 2.5 {
	speed = 2.5
}