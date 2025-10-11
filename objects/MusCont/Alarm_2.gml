/// @description Stage-dependent boss music
audio_stop_sound(song)
audio_stop_sound(amb)

switch GameCont.area {
	case area_desert: song = musBoss1
	case area_sewers: song = musBoss5
	case area_scrapyards: song = musBoss2
	case area_city: song = musBoss3
	case area_palace: song = musBoss4A
	case area_campfire: song = musBoss4B
	case area_caves: song = musBoss6
	case area_cursed_caves: song = musBoss6B
	case area_labs: song = musBoss7
	case area_hq: song = musBoss8
}

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song)
snd_play_ambience(amb)