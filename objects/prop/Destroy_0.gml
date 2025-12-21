if (corpse && sprite_exists(spr_dead)) {
	with (instance_create(x, y, Corpse)) {
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
		sprite_index = other.spr_dead
		size = other.size
	}
}

if (is_numeric(snd_dead) && audio_exists(snd_dead)) snd_play_hit(snd_dead, 0.2)

if (raddrop > 0) scrRadDrop(x, y, raddrop)