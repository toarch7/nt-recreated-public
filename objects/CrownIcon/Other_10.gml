scrCrownSetCurrent(crown)
GameCont.crownpoints -= 1

with instance_create(0, 0, SkillText) {
    txt = other.crown_name[other.crown]
}

instance_destroy(CrownIcon)
instance_destroy(LevCont)

if GameCont.crownpoints > 0 || GameCont.skillpoints > 0 || GameCont.ultrapoints > 0 {
    instance_create(x, y, LevCont)
}
else {
    instance_create(x, y, GenCont)
}

with CrownObject is_new = true

snd_play(crown_sond[crown])