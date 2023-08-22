var oldarea;
oldarea = area
subarea = 1

if !instance_exists(GameCont)
	exit

area = GameCont.area
subarea = GameCont.subarea

if GameCont.race == 13 {
    if song
		audio_stop_sound(song)
	
	if amb
		audio_stop_sound(amb)
	
    song = musBoss2
    amb = -1
	
    song = custom_sound_check(song)
	
    snd_loop(song)
    alarm[0] = -1
	
    exit
}

if instance_exists(Player)
	alarm[0] = -1

if oldarea != area or audio_is_playing(song) or !audio_is_playing(amb) {
    audio_stop_sound(song)
    audio_stop_sound(amb)
	
	var _song = asset_get_index("mus" + string(GameCont.area)),
		_amb = asset_get_index("amb" + string(GameCont.area))
	
	if sound_exists(_song) {
		if GameCont.proto {
			var _songb = asset_get_index(audio_get_name(_song) + "b")
			
			if sound_exists(_songb)
				_song = _songb
		}
		
		song = _song
	}
	else song = musBoss4Silence
	
	if sound_exists(_amb) {
		amb = _amb
	}
	else amb = amb0b
	
	// special tunes
    if area == 0 {
        song = musBoss4Silence
        amb = amb0b
    }
	
    if area == 106 {
        song = mus106
		
		with Player {
			if is_me && race == 12 {
				other.song = mus106b
			}
        }
		
        amb = amb106
    }
	
	//
    song = custom_sound_check(song)
    amb = custom_sound_check(amb)

    snd_play_music(song, true)
    snd_play_ambient(amb, true)
}