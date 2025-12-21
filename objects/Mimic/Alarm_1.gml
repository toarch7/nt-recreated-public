alarm[1] = 90 + random(150)

spr_idle = sprMimicTell
sprite_index = spr_idle
image_index = 0

if (image_speed > 0) {
	alarm[2] = image_number / image_speed
}
else {
	alarm[2] = 1
}

snd_play_hit(sndMimicSlurp, 0.2)