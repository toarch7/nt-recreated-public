alarm[3] = -1

if !instance_exists(Player) && !instance_exists(Menu) {
    alarm[0] = 1268
    
	snd_stop(song)
    snd_stop(amb)
	
    song = musThemeA
    song = custom_sound_check(song)
}