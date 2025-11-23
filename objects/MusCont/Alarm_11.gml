/// @description Update area theme
if !instance_exists(GameCont) exit

with Player {
	if race == Race.BigDog {
		with other {
			if song audio_stop_sound(song)
			if amb audio_stop_sound(amb)
			
		    song = custom_sound_check(musBoss2)
		    amb = -1
			
		    snd_play_loop(song)
		    alarm[0] = -1
		}
		
	    exit
	}
}

if instance_exists(Player)
	alarm[0] = -1

var _area = GameCont.area

if oldarea != _area || !audio_is_playing(song) || !audio_is_playing(amb) {
    audio_stop_sound(song)
    audio_stop_sound(amb)
	
	var _song = asset_get_index("mus" + string(_area)),
		_amb = asset_get_index("amb" + string(_area))
	
	if audio_exists(_song) {
		if GameCont.proto && _area != Area.Vault {
			var _songb = asset_get_index(audio_get_name(_song) + "b")
			
			if audio_exists(_songb) {
				_song = _songb
			}
		}
		
		song = _song
	}
	else song = musBoss4Silence
	
	if audio_exists(_amb) {
		amb = _amb
	}
	else amb = amb0b
	
	// special tunes
    if _area == Area.Campfire {
        song = musBoss4Silence
        amb = amb0b
    }
	
    if _area == Area.HQ {
        song = mus106
		
		with Player {
			if is_me && race == Race.Rogue {
				other.song = mus106b
			}
        }
		
        amb = amb106
    }
	
	//
    song = custom_sound_check(song)
    amb = custom_sound_check(amb)

    snd_play_music(song, true)
    snd_play_ambience(amb, true)
	
	oldarea = _area
}