if (!instance_exists(GameCont)) exit

visible = true
sprite_index = spr_idle
depth = -2

if scr_player_is_local(index) {
	if (!UberCont.want_menu && !UberCont.want_restart) {
		scrUnlocksArea()
	}
	
	if (race == Race.Frog && !scrGameIsWeeklyRun()) scrRaceUnlock(Race.Frog)
	
    scrPlayerTryUnlockGoldenWeapons(id)
}

reload = 0
breload = 0

can_shoot = true
bcan_shoot = true

frogcharge = 0
froggas = 0

if !instance_exists(CrownObject) && GameCont.crown > 1 {
    with instance_create(x, y, CrownObject) {
        if (GameCont.area > 1)
		|| (GameCont.subarea > 1)
		|| ((GameCont.loops - global.hardmode) > 0) {
            is_new = false
        }
    }
}

with CrownObject {
    x = other.x
    y = other.y

    spr_idle = asset_get_index("sprCrown" + string(GameCont.crown) + "Idle")
    spr_walk = asset_get_index("sprCrown" + string(GameCont.crown) + "Walk")
}

GameCont.deathcause = HitId.None

if (scrCrownCheck(Crown.Luck)) hp = 1

mask_index = mskPlayer

if race == Race.BigDog {
    mask_index = mskScrapBoss
}

if race == Race.Rebel {
    hp = min(hp + floor((max_hp - hp) / 2), max_hp)
	
	if bskin == SkinLetter.B {
	    if GameCont.area == area_city {
	        spr_idle = sprMutant10CIdle
	        spr_walk = sprMutant10CWalk
	        spr_hurt = sprMutant10CHurt
	        spr_dead = sprMutant10CDead
	    }
		else {
	        spr_idle = sprMutant10BIdle
	        spr_walk = sprMutant10BWalk
	        spr_hurt = sprMutant10BHurt
	        spr_dead = sprMutant10BDead
	    }
	}
}

scr_playerinstance_find(index).hp = hp