song = -1
amb = -1
ambfilter = 1
oldarea = area_campfire
song = custom_sound_check(musThemeA)
amb = custom_sound_check(amb0)

if !snd_is_playing(musCredits) {
    snd_play_music(song)

    alarm[0] = audio_sound_length(song) * 30

    if song == musThemeA {
        alarm[0] -= 160
    }

    if !alarm[0] alarm[0] = 30

    snd_play(sndRestart)
}

audio_master_gain(UberCont.opt_volume)
audio_sound_gain(song, UberCont.opt_musvol, 0)
audio_sound_gain(amb, UberCont.opt_ambvol, 0)

scrVolume()