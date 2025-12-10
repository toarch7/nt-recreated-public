/// @description Boss win jingle
audio_stop_sound(song)

var _snd = sndBossWin, _amb = custom_sound_check(amb)

if instance_exists(CrownPed) _snd = sndVaultBossWin

_snd = custom_sound_check(_snd)

snd_play_music(_snd)
snd_play_ambience(_amb)

var _area = GameCont.area

if _area != area_palace || _area != area_campfire {
	alarm[3] = 180
}