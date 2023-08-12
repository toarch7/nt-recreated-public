if instance_exists(Player) && GameCont.area != 7 && GameCont.area != 106 {
    song = musBossDead
    song = custom_sound_check(song)
	snd_play_music(song, true)
}