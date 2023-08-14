audio_stop_sound(song)

var snd = sndBossWin

if instance_exists(CrownPed)
	snd = sndVaultBossWin

snd = custom_sound_check(snd)
amb = custom_sound_check(amb)

snd_play_music(snd)
snd_play_ambient(amb)

if GameCont.area != 7 && GameCont.area != 0
	alarm[3] = 180