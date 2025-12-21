/// @description Boss dead music
var _area = GameCont.area

if instance_exists(Player) && _area != area_palace && _area != area_hq {
    song = custom_sound_check(musBossDead)
	snd_play_music(song, false)
}