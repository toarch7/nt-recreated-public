alarm[3] = -1
alarm[6] = -1

if !instance_exists(GameCont) && !instance_exists(Menu) {
    alarm[0] = 1268
    
	snd_stop(song)
    snd_stop(amb)
	
    song = custom_sound_check(musThemeA)
}