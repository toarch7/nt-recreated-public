/// @description init_player(index): object
/// @param index
/// @param race
function scrSpawnPlayer(_index = 0, _race = 1, _skin = 0) {
    var player = instance_create(x, y, Player)

    with player {
        index = _index
        is_me = 1

        gunangle = 0
        p = 0

        patient = -1

        team = 2
        size = 5

        cantoxic = 1

        race = _race

        if race == 0 {
            while !UberCont.cgot[race]
            race = irandom(11) + 1

            GameCont.race = race
        }

        crown = GameCont.crown

        if race == 0 crown = 1

        raddrop = 0

        scrRaces()
        scrWeapons()
        scrCrowns()
        scrUltras()
        scrSkills()

        ultra = 0

        if UberCont.daily_run && !UberCont.weekly_run {
            GameCont.crown = 1
            crown = 1
        }

        if race == 15 {
            wep = 255
            cantoxic = 0
        }

        bwep = 0
        curse = 0
        bcurse = 0
        reload = 0
        breload = 0
        fingers = 0
        spirit = 0
        can_spirit = 0
        accuracy = 1

        ammo[0] = 999
        ammo[1] = 0
        ammo[2] = 0
        ammo[3] = 0
        ammo[4] = 0
        ammo[5] = 0

        max_hp = 8

        maxspeed = 4
        footextra = 0
        footstep = 0

        level = 1
        skillpoints = 0
        crownpoints = 0

        //RACE STUFF
        bskin = _skin

        if !bskin or !sprite_exists(asset_get_index("sprMutant" + string(race) + "BIdle")) {
            spr_idle = asset_get_index("sprMutant" + string(race) + "Idle")
            spr_walk = asset_get_index("sprMutant" + string(race) + "Walk")
            spr_hurt = asset_get_index("sprMutant" + string(race) + "Hurt")
            spr_dead = asset_get_index("sprMutant" + string(race) + "Dead")
            spr_gosit = asset_get_index("sprMutant" + string(race) + "GoSit")
            spr_sit = asset_get_index("sprMutant" + string(race) + "Sit")
        }
		else if sprite_exists(asset_get_index("sprMutant" + string(race) + "BIdle")) {
            spr_idle = asset_get_index("sprMutant" + string(race) + "BIdle")
            spr_walk = asset_get_index("sprMutant" + string(race) + "BWalk")
            spr_hurt = asset_get_index("sprMutant" + string(race) + "BHurt")
            spr_dead = asset_get_index("sprMutant" + string(race) + "BDead")
            spr_gosit = asset_get_index("sprMutant" + string(race) + "BGoSit")
            spr_sit = asset_get_index("sprMutant" + string(race) + "BSit")
        }

        if race == 9 {
            spr_dead = sprMutant9Dead
        }

        snd_hurt = sndMutant1Hurt
        snd_dead = sndMutant1Dead
        snd_lowa = sndMutant1LowA
        snd_lowh = sndMutant1LowH
        snd_crwn = sndMutant1Crwn
        snd_chst = sndMutant1Chst
        snd_wrld = sndMutant1Wrld
        snd_thrn = sndMutant1Thrn
        snd_valt = sndMutant1Valt
        snd_spch = sndMutant1Spch
        snd_cptn = sndMutant1Spch

        if race > 0 {
            snd_hurt = asset_get_index("sndMutant" + string(race) + "Hurt")
            snd_dead = asset_get_index("sndMutant" + string(race) + "Dead")
            snd_lowa = asset_get_index("sndMutant" + string(race) + "LowA")
            snd_lowh = asset_get_index("sndMutant" + string(race) + "LowH")
            snd_crwn = asset_get_index("sndMutant" + string(race) + "Crwn")
            snd_chst = asset_get_index("sndMutant" + string(race) + "Chst")
            snd_wrld = asset_get_index("sndMutant" + string(race) + "Wrld")
            snd_thrn = asset_get_index("sndMutant" + string(race) + "Thrn")
            snd_valt = asset_get_index("sndMutant" + string(race) + "Valt")
            snd_spch = asset_get_index("sndMutant" + string(race) + "Spch")
            snd_cptn = asset_get_index("sndMutant" + string(race) + "Cptn")
        }

        if race == 2 {
            max_hp = 10
        }

        if race == 4 {
            max_hp = 2
        }

        if race == 5 {
            maxspeed = 4.5
        }

        if race == 7 {
            bwep = 1
            accuracy = 1.8
        }
		
        if race == 13 {
            spr_idle = sprScrapBossIdle
            spr_walk = sprScrapBossWalk
            spr_hurt = sprScrapBossHurt
            spr_dead = sprScrapBossDead
            spr_gosit = sprScrapBossWalk
            spr_sit = sprScrapBossSleep
            max_hp = 300
            maxspeed = 2

            snd_hurt = sndBigDogHit
            snd_lowh = sndBigDogHalfHP
            snd_lowa = sndBigDogIntro
            snd_dead = sndBigDogDeath
            snd_wrld = sndBigDogIntro
            snd_thrn = sndBigDogTaunt
            snd_cptn = sndBigDogTaunt
            snd_spch = sndBigDogTaunt

            spr_shadow = shd96
            mask_index = mskScrapBoss

            ammo[1] += 255
            ammo[4] += 55

            can_pick = 0
        }

        if race == 14 {
            maxspeed = 3
            accuracy = 1.5
            max_hp = 4
            hp = 4
        }

        last_hit = -1

        hp = max_hp
        lsthealth = max_hp
        inframes = 0

        //default shit
        clicked = 0

        wepflip = 1
        angle = 0
        wkick = 0
        bwkick = 0
        bwepangle = 0
        bwepflip = 1

        bleed = 0
        headloses = 0
        crownrad = 0
        crownvisits = 0
        can_shoot = 1
        bcan_shoot = (race == 7)
        right = 1
        wepright = 1
        back = 1
        wave = 0
        roll = 0
        drawempty = 0
        drawlowhp = 0
        canrebel = 1

        spirit_anim = 0
        spirit_index = 0

        infammo = 0

        last_hp = hp
        hp_diff = 0

        show_empty_cooldown = 0

        rogue_ammo = 1
        rogue_ammo_max = 3
        hammerhead = 0
        hammerheads = 0

        alarm[11] = 1

        aimassist_wait = 0
        canwalk = 1

        canshield = 0
        horrorbeam = 0
		skeletongamble = 0
        frogcharge = 0
        froggas = 0
        horrortime = 0
        horrornorad = 0
    }

    return player
}