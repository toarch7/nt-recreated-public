snd_stop(sndCuzCryNew)
snd_stop(sndCuzCry)

for(var i = 1; i <= 10; ++i) {
	var _sound = asset_get_index("sndCuzCryBonus" + string(i))
	if (audio_exists(_sound)) snd_stop(_sound)
}

snd_play_hit(sndCuzOutaway, 0.1)