skill_set(skill, 1)

with instance_create(0, 0, SkillText) {
    txt = other.skill_name[other.skill]
    show_debug_message("skill issue " + string(other.skill))
}

with Player {
    skill = other.skill

    if skill == 1 {
        max_hp += 4
        hp += 4
    }

    if skill == 2 {
        maxspeed += 0.5
        footextra = 1
    }

    if skill == 10 {
        scrWeapons()
    }

    if skill == 18 {
        ammo[1] += 200
        ammo[2] += 20
        ammo[3] += 20
        ammo[4] += 20
        ammo[5] += 20

        if headloses {
            max_hp += headloses
            headloses = 0
        }

        for (var i = 1; i <= 5; i++) {
            if ammo[i] > typ_amax[i] ammo[i] = typ_amax[i]
        }

        hp = max_hp

        if curse or bcurse snd_play(sndUncurse)

        if race == 12 && rogue_ammo < rogue_ammo_max {
            rogue_ammo = rogue_ammo_max
        }

        curse = 0
        bcurse = 0
    }

    if skill == 19 accuracy *= 0.4

    if skill == 27 spirit = 1
}

if skill == 21 or skill == 17 or skill == 16 or skill == 15 or skill == 14 or skill == 13 {
    GameCont.heavyheart++
}

GameCont.skillpoints--

if skill == 28 {
    GameCont.openminds++
}

with SkillIcon
instance_destroy()

with LevCont
instance_destroy()

if GameCont.skillpoints > 0 or GameCont.ultrapoints > 0 {
    instance_create(x, y, LevCont)
} else {
    with instance_create(x, y, GenCont)
    race = GameCont.race
}

if GameCont.area != 101 snd_play(skill_msnd[skill])
else snd_play(sndOasisShoot)

scrGameSave()