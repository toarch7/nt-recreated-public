if lockstep_stop
	exit

if (hp <= 0) instance_destroy()
if (wkick != -1) {
    if (wkick > 0) wkick -= 1
    if (wkick < 0) wkick += 1
}
if (spr_idle != sprAllyAppear) {
    if (spr_chrg != -1) {
        if ((sprite_index != spr_hurt) && (sprite_index != spr_chrg)) sprite_index = spr_idle
        if ((sprite_index == spr_hurt) || (sprite_index == spr_chrg)) {
            if (image_index > 2) sprite_index = spr_idle
        }
    } else if (spr_fire != -1) {
        if (speed == 0) {
            if ((sprite_index != spr_hurt) && (sprite_index != spr_fire)) sprite_index = spr_idle
        } else if ((sprite_index != spr_hurt) && (sprite_index != spr_fire)) sprite_index = spr_walk
        if ((sprite_index == spr_hurt) || (sprite_index == spr_fire)) {
            if (image_index > 2) sprite_index = spr_idle
        }
    } else {
        if (speed == 0) {
            if (sprite_index != spr_hurt) sprite_index = spr_idle
        } else if (sprite_index != spr_hurt) sprite_index = spr_walk
        if (sprite_index == spr_hurt) {
            if (image_index > 2) sprite_index = spr_idle
        }
    }
} else {
    hp = max_hp
    if (sprite_index != spr_idle) spr_idle = sprAllyIdle
}
if (walk > 0) {
    walk -= 1
    motion_add(direction, 0.8)
}
if (instance_exists(creator) && (spr_idle != sprAllyAppear)) {
    if (point_distance(x, y, creator.x, creator.y) > 52) mp_potential_step(creator.x, creator.y, 1, 0)
}
if (speed > 4.5) speed = 4.5
if ((hp <= 2) && (random((4 * hp)) < 1)) instance_create(x, y, AllyDamage)
if (instance_exists(Portal) && (alarm[2] > 2)) alarm[2] = 1