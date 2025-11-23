/// @description Boss dead music
var _area = GameCont.area

if instance_exists(Player) && _area != Area.Palace && _area != Area.HQ {
    song = custom_sound_check(musBossDead)
	snd_play_music(song, true)
}