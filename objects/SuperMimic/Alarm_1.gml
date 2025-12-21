alarm[1] = 150 + random(180)

spr_idle = sprSuperMimicTell
sprite_index = spr_idle
image_index = 0

if (image_speed > 0) {
	alarm[2] = image_number / image_speed
}
else {
	alarm[2] = 1
}

snd_play_hit(sndHPMimicTaunt, 0.2)