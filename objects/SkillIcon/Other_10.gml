/// @description Select

GameCont.skillpoints --

scr_skill_set(skill, scr_skill_get(skill) + 1)
snd_play(GameCont.underwater ? sndOasisShoot : scr_skill_get_sound(skill))
scrLevelUpScreenSubmit(loc("Skills", skill, "Name", scr_crown_get_name(skill)))