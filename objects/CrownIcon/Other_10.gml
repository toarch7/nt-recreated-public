if crown == 0 {
    crown = ceil(random(crownmax - 1) + 1)
}

var oldcrown = GameCont.crown
GameCont.crown = crown
GameCont.crownpoints -= 1

with instance_create(0, 0, SkillText) {
    txt = other.crown_name[other.crown]
}

//NONE
if crown == 1 {
    with Crown
    instance_destroy()
}

//CROWN OF DEATH
if oldcrown == 2 with Player max_hp += 1

//DO STUFF

//CROWN OF DESTINY
if crown == 8 && !GameCont.destiny {
    GameCont.skillpoints += 1
    GameCont.destiny = 1

    scrGameSave()
}

//CROWN OF DEATH
if crown == 2 {
    with Player {
        max_hp -= 1

        if hp > max_hp hp = max_hp
    }
}

with CrownIcon
instance_destroy()

with LevCont
instance_destroy()

if GameCont.crownpoints > 0 or GameCont.skillpoints > 0 or GameCont.ultrapoints > 0 {
    instance_create(x, y, LevCont)
} else {
    instance_create(x, y, GenCont)
}

with Crown
is_new = 1

snd_play(crown_sond[crown])