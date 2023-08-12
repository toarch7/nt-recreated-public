var oldarea;
oldarea = area
subarea = 1

if instance_exists(GameCont) {
    area = GameCont.area
    subarea = GameCont.subarea

    if GameCont.race == 13 {
        if song audio_stop_sound(song) if amb audio_stop_sound(amb)

        song = musBoss2
        amb = -1

        song = custom_sound_check(song)

        snd_loop(song)
        alarm[0] = -1

        exit
    }
}

if instance_exists(Player) alarm[0] = 0
if ((oldarea != area) || ((!snd_is_playing(song)) || (!audio_exists(song)))) {
    audio_stop_sound(song)
    audio_stop_sound(amb)
    if (area == 0) {
        song = musBoss4Silence
        amb = amb0b
    }
    if (area == 1) {
        if (GameCont.proto == 1) song = mus1b
        else song = mus1
        amb = amb1
    }
    if (area == 2) {
        song = mus2
        amb = amb2
    }
    if (area == 3) {
        if (GameCont.proto == 1) song = mus3b
        else song = mus3
        amb = amb3
    }
    if (area == 4) {
        song = mus4
        amb = amb4
    }
    if (area == 5) {
        if (GameCont.proto == 1) song = mus5b
        else song = mus5
        amb = amb5
    }
    if (area == 6) {
        song = mus6
        amb = amb6
    }
    if (area == 7) {
        if (GameCont.proto == 1) song = mus7b
        else song = mus7
        amb = amb7
    }
    if (area == 100) {
        song = mus100
        amb = amb100
    }
    if (area == 101) {
        song = mus101
        amb = amb101
    }
    if (area == 102) {
        song = mus102
        amb = amb102
    }
    if (area == 103) {
        song = mus103
        amb = amb103
    }
    if (area == 104) {
        song = mus104
        amb = amb104
    }
    if (area == 105) {
        song = mus105
        amb = amb105
    }
    if (area == 106) {
        song = mus106
		
		with Player {
			if is_me && race == 12 {
				other.song = mus106b
			}
        }
		
        amb = amb106
    }
    if (area == 107) {
        song = mus107
    }

    song = custom_sound_check(song)
    amb = custom_sound_check(amb)

    snd_play_music(song, true)
    snd_play_ambient(amb, true)
}