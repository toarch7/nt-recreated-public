audio_stop_sound(song)
audio_stop_sound(amb)

if (GameCont.area == 1) song = musBoss1
if (GameCont.area == 2) song = musBoss5
if (GameCont.area == 3) song = musBoss2
if (GameCont.area == 5) song = musBoss3
if (GameCont.area == 7) song = musBoss4A
if (GameCont.area == 0) song = musBoss4B
if (GameCont.area == 4) song = musBoss6
if (GameCont.area == 104) song = musBoss6B
if (GameCont.area == 6) song = musBoss7
if (GameCont.area == 106) song = musBoss8

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song)
snd_play_ambient(amb)