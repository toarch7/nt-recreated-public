with instance_create(x, y, ChestOpen) {
	sprite_index = other.spr_dead
	image_index = sprite_get_number(sprite_index) - 1
}

instance_create(x, y, FXChestOpen)

if skill_get(9) {
    snd_play(sndHealthChestBig)
}
else snd_play(sndHealthChest)

