GameCont.crownpoints -= 1

scrCrownSetCurrent(crown)
scrLevelUpScreenSubmit(loc("Crowns", crown, "Name", scr_crown_get_name(crown)))
snd_play(GameCont.underwater ? sndOasisShoot : scr_crown_get_sound(crown))
with (CrownObject) is_new = true