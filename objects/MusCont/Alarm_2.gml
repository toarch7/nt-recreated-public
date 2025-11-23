/// @description Stage-dependent boss music
audio_stop_sound(song)
audio_stop_sound(amb)

switch GameCont.area {
	case Area.Desert: song = musBoss1
	case Area.Scrapyards: song = musBoss2
	case Area.City: song = musBoss3
	case Area.Palace: song = musBoss4A
	case Area.Campfire: song = musBoss4B
	// loop
	case Area.Sewers: song = musBoss5
	case Area.CrystalCaves: song = musBoss6
	case Area.CursedCaves: song = musBoss6B
	case Area.Labs: song = musBoss7
	case Area.HQ: song = musBoss8
}

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song)
snd_play_ambience(amb)