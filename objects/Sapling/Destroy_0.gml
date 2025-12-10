instance_create(x, y, MeatExplosion)

var _ang = random_angle

snd_play_hit(sndSaplingDead, 0.2)

repeat (3) {
	with scr_damage_create(
		x + ldrx(24, _ang), y + ldry(24, _ang), MeatExplosion
	) {
		creator = other.creator
	}
	
	_ang += 120
}

with instance_create(x, y, CorpseActive) {
	sprite_index = other.spr_dead
	size = other.size
	image_xscale *= other.right
	direction = other.direction
	speed = min(16, other.speed)
	if (size != 0) speed /= size
}