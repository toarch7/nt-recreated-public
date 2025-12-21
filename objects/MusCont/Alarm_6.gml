/// @description Special campfire theme
with Campfire {
	if (sprite_index != sprCampfireBear) exit
}

audio_stop_sound(song)
audio_stop_sound(amb)

song = musThemeP
song = custom_sound_check(song)

snd_play_music(song)
snd_play_ambience(amb, true)