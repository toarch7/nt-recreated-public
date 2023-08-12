audio_stop_sound(song)

if instance_exists(CrownPed) {
	song = sndVaultBossWin
}
else song = sndBossWin

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song)
snd_play_ambient(song)

if GameCont.area != 7 && GameCont.area != 0
	alarm[3] = 180