/// @description Intro sequence

if image_index >= image_number - 1 exit

image_index = floor(image_index + 1)

if image_index >= 7 {
	snd_play_ambience(sndLogoLoop)
	
	snd_play(sndShovel)
	snd_play(sndMeatExplo)
	snd_play(sndExplosion)
	
	shake += 2.5
}
else {
	alarm[0] = (image_index == 6) ? 20 : 2
	snd_play(sndMachinegun)
	shake += 0.5
}