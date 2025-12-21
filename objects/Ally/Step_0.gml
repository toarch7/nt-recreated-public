if lockstep_stop
	exit

if (setup) {
	if (instance_exists(creator)) {
		bskin = creator.bskin
	}
	
	if (bskin == SkinLetter.C) {
		spr_idle = sprAllyCIdle
		spr_walk = sprAllyCWalk
		spr_hurt = sprAllyCHurt
		spr_dead = sprAllyCDead
		spr_appear = sprAllyCAppear
		if (sprite_index == sprAllyAppear) {
			sprite_index = spr_appear
		}
	}
}

if (sprite_index != spr_appear) {
    if (speed == 0) {
        if (sprite_index != spr_hurt) sprite_index = spr_idle
    }
	else {
		if (sprite_index != spr_hurt) sprite_index = spr_walk
	}
	
	if (sprite_index == spr_hurt) {
        if (image_index > 2) sprite_index = spr_idle
    }
	
	if (hp <= 0) instance_destroy()
}
else if (animation_end) {
    sprite_index = spr_idle
    hp = max_hp
}

if (walk > 0) {
    motion_add(direction, 0.8)
    walk -= timescale
}

if (instance_exists(creator) && sprite_index != spr_appear) {
    if (point_distance(x, y, creator.x, creator.y) > 52) {
		direction = point_direction(x, y, creator.x, creator.y)
		mp_potential_step(creator.x, creator.y, 1, 0)
	}
}

if (speed > 4.5) speed = 4.5

if (wkick != 0) wkick = approach(wkick, 0, timescale)

if (current_frame_active && hp <= 2 && random(4 * hp) < 1) instance_create(x, y, AllyDamage)

if (instance_exists(Portal) && alarm[2] > 2) alarm[2] = 1