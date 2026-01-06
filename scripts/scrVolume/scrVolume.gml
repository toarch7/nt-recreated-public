function scrVolume() {
    audio_master_gain(clamp(UberCont.opt_volume, 0, 1))
	
	//
	var _music_volume = clamp(UberCont.opt_musvol, 0, 1)
	audio_sound_gain(sndBossWin, _music_volume, 0)
    audio_sound_gain(musBossDead, _music_volume, 0)
    audio_sound_gain(musThemeA, _music_volume, 0)
    audio_sound_gain(musThemeB, _music_volume, 0)
    audio_sound_gain(musThemeP, _music_volume, 0)
    audio_sound_gain(musBoss1, _music_volume, 0)
    audio_sound_gain(musBoss2, _music_volume, 0)
    audio_sound_gain(musBoss3, _music_volume, 0)
    audio_sound_gain(musBoss4A, _music_volume, 0)
    audio_sound_gain(musBoss4B, _music_volume, 0)
    audio_sound_gain(musBoss5, _music_volume, 0)
    audio_sound_gain(musBoss6, _music_volume, 0)
    audio_sound_gain(musBoss7, _music_volume, 0)
    audio_sound_gain(musBoss8, _music_volume, 0)
	
	//
	var _ambient_volume = clamp(UberCont.opt_ambvol, 0, 1)
    audio_sound_gain(sndPortalLoop, _ambient_volume, 0)
    audio_sound_gain(sndCarLoop, _ambient_volume, 0)
}