audio_stop_sound(song)
if instance_exists(CrownPed) song = sndVaultBossWin
else song = sndBossWin
song = custom_sound_check(song)
amb = custom_sound_check(amb)
snd_play(song)
snd_loop(amb)
if ((GameCont.area != 7) && (GameCont.area != 0)) alarm[3] = 180
audio_sound_set_track_position(amb, random(audio_sound_length(amb)))