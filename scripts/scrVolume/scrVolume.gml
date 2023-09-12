function scrVolume() {
    with MusCont {
        var mvol = clamp(UberCont.opt_musvol, 0, 1),
			avol = clamp(UberCont.opt_ambvol, 0, 1)
        audio_master_gain(clamp(UberCont.opt_volume, 0, 1))

        //if audio_exists(song)
        //audio_sound_gain(song, mvol, 0)

        //if audio_exists(amb)
        //audio_sound_gain(amb, clamp(UberCont.opt_ambvol, 0, 1), 0)
		
        audio_sound_gain(sndBossWin, mvol, 0)
        audio_sound_gain(musBossDead, mvol, 0)
        audio_sound_gain(musThemeA, mvol, 0)
        audio_sound_gain(musThemeB, mvol, 0)
        audio_sound_gain(musThemeP, mvol, 0)
        audio_sound_gain(musBoss1, mvol, 0)
        audio_sound_gain(musBoss2, mvol, 0)
        audio_sound_gain(musBoss3, mvol, 0)
        audio_sound_gain(musBoss4A, mvol, 0)
        audio_sound_gain(musBoss4B, mvol, 0)
        audio_sound_gain(musBoss5, mvol, 0)
        audio_sound_gain(musBoss6, mvol, 0)
        audio_sound_gain(musBoss7, mvol, 0)
        audio_sound_gain(musBoss8, mvol, 0)

        audio_sound_gain(sndPortalLoop, avol, 0)
        audio_sound_gain(sndCarLoop, avol, 0)
    }
}