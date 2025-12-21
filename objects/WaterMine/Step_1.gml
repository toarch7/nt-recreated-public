if (hp <= 0) {
	nexthurt = current_frame + 999
	sprite_index = spr_dead
	mask_index = mskNone
	hp = 1
}

event_inherited()

x = xstart
y = ystart
