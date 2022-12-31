audio_stop_all()
song = musBoss4B
amb = amb0c

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play(song)
snd_loop(amb)
audio_sound_set_track_position(amb, random(audio_sound_length(amb)))