function projectile_hit_self(damage) {
	hp -= damage
	
	sprite_index = spr_hurt
	image_index = 0
	
	snd_play_hit(snd_hurt, 0.2)
}