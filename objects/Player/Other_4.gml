if !instance_exists(GameCont) // how?? why??
	exit

visible = 1
sprite_index = spr_idle
frogcharge = 0

view_xview = x - view_width / 2
view_yview = y - view_height / 2

if is_me {
    GameCont.race = race
    GameCont.bskin = bskin
    scrUnlock()
}

reload = 0
breload = 0

can_shoot = 1
bcan_shoot = 1

frogcharge = 0
froggas = 0

if !instance_exists(Crown) && GameCont.crown > 1 {
    with instance_create(x, y, Crown) {
        if (GameCont.area > 1) or (GameCont.subarea > 1) or ((GameCont.loops - global.hardmode) > 0) {
            is_new = 0
        }
    }
}

with Crown {
    x = other.x
    y = other.y

    spr_idle = asset_get_index("sprCrown" + string(GameCont.crown) + "Idle")
    spr_walk = asset_get_index("sprCrown" + string(GameCont.crown) + "Walk")
}

if GameCont.crown == 10 {
    hp = 1
}

if race == 15 && is_me && !UberCont.weekly_run {
    if !UberCont.cgot[15] {
        UberCont.cgot[15] = 1

        show_unlock_popup("@wFROG UNLOCKED@s#PLAYING THE FROG")

        with instance_create(x, y, UnlockScreen) {
            race = 15
            skin = 0
        }
    }

    scrAchievement(27)
}

view_xview = x + view_width / 2
view_yview = y + view_height / 2

last_hit = -1
mask_index = mskPlayer

if race == 13 {
    mask_index = mskScrapBoss
}

if race == 10 {
    hp = min(hp + floor((max_hp - hp) / 2), max_hp)

    if bskin && GameCont.area == 5 {
        spr_idle = sprMutant10CIdle
        spr_walk = sprMutant10CWalk
        spr_hurt = sprMutant10CHurt
        spr_dead = sprMutant10CDead
    } else if bskin {
        spr_idle = sprMutant10BIdle
        spr_walk = sprMutant10BWalk
        spr_hurt = sprMutant10BHurt
        spr_dead = sprMutant10BDead
    }
}