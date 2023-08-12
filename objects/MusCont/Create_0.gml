wantmusic = 1
area = 0
song = -1
amb = -1
ambfilter = 1
song = musThemeA
amb = amb0
song = custom_sound_check(song)
amb = custom_sound_check(amb)

if !snd_is_playing(musCredits) {
    snd_play_music(song)

    alarm[0] = audio_sound_length(song) * 30

    if song == musThemeA {
        alarm[0] -= 160
    }

    if !alarm[0] alarm[0] = 30

    snd_play(sndRestart)
}

if (file_exists("nomusic.txt") || (file_exists("NOMUSIC.txt") || (file_exists("NOMUSIC.TXT") || file_exists("nomusic.TXT")))) wantmusic = 0
if (wantmusic == 0) {
    UberCont.opt_musvol = 0
    UberCont.opt_ambvol = 0
}

audio_master_gain(UberCont.opt_volume)
audio_sound_gain(song, UberCont.opt_musvol, 0)
audio_sound_gain(amb, UberCont.opt_ambvol, 0)

scrVolume()