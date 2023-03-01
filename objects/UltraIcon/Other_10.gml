var num = id.num

with instance_create(0, 0, SkillText) {
    txt = other.ultr_name[other.race, num]
}

with UltraIcon
instance_destroy()

with LevCont
instance_destroy()

GameCont.ultrapoints--

if !instance_exists(CoopController) {
    with Player ultra = num
    GameCont.ultra = num

    snd_play(ultr_msnd[race, num])

    if race == 6 {
        GameCont.gocrib = 1
        room_restart()
    }

    with Player {
        if race == 2 && num == 1 //CRYSTAL'S FORTRESS
        {
            max_hp += 6;
            hp += 6
        }
    }

    if race == 4 && num == 2 { //MELTING'S DETACHMENT 
        with Player {
            if race == 4 {
                max_hp = ceil(max_hp / 2)
                hp = max_hp

                hp = min(max_hp, hp)
                lsthealth = hp

                GameCont.skillpoints++
            }
        }

        GameCont.skillpoints += 2
    }

    with Player {
        if race == 12 && num == 1 //ROGUE'S SUPER PORTAL STRIKE
        {
            rogue_ammo_max += 3
        }
    }

    if race == 14 && num == 1 { // REDEMPTION
        with Player
        if race == 14 {
            race = 4
            ultra = 0

            with GameCont {
                level = 10
                rad = 0
                race = 4
                ultrapoints++ultra = 0
                GameCont.skillpoints += 8
                ds_list_clear(skills)
                wasskeleton = 1
            }

            maxspeed = 4
            accuracy = 1
            max_hp = 2

            spr_idle = sprMutant4Idle
            spr_walk = sprMutant4Walk
            spr_hurt = sprMutant4Hurt
            spr_dead = sprMutant4Dead
            spr_gosit = sprMutant4GoSit
            spr_sit = sprMutant4Sit

            snd_hurt = sndMutant4Hurt
            snd_dead = sndMutant4Dead
            snd_chst = sndMutant4Chst
            snd_valt = sndMutant4Valt
            snd_wrld = sndMutant4Wrld
            snd_crwn = sndMutant4Crwn
            snd_lowa = sndMutant4LowA
            snd_lowh = sndMutant4LowH

            if GameCont.crown == 2 {
                max_hp--
            }

            hp = min(max_hp, hp)
            lsthealth = hp

            playerinstance_get(index).race = 4
        }
    }
} else {
    with GameCont {
        coopultra = other.num
    }

    with Player {
        if race == 6 {
            GameCont.gocrib = 1
            room_restart()
        }
    }

    if !num {
        snd_play(sndCoopUltraA)
    } else snd_play(sndCoopUltraB)
}

if GameCont.crownpoints > 0 or GameCont.skillpoints > 0 or GameCont.ultrapoints > 0 {
    instance_create(x, y, LevCont)
}
else {
    with instance_create(x, y, GenCont) {
		race = GameCont.race
	}
}