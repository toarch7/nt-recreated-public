/// @description Stage-dependent boss music
audio_stop_sound(song)
audio_stop_sound(amb)

switch GameCont.area {
	case area_desert: song = musBoss1 break
	case area_sewers: song = musBoss5 break
	case area_scrapyards: song = musBoss2 break
	case area_city: song = musBoss3 break
	case area_palace: song = musBoss4A break
	case area_campfire: song = musBoss4B break
	case area_caves: song = musBoss6 break
	case area_cursed_caves: song = musBoss6B break
	case area_labs: song = musBoss7 break
	case area_hq: song = musBoss8 break
	case area_crib: song = musBoss9 break
}

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song, true)
snd_play_ambience(amb)