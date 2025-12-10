if self[$ "corpse"] {
    with instance_create(x, y, Corpse) {
        size = other.size
        sprite_index = other.spr_dead
        image_xscale = other.image_xscale
    }
}

if (raddrop > 0) scrRadDrop(x, y, raddrop)

if isset("snd_dead")
	snd_play_hit(snd_dead, 0.2)