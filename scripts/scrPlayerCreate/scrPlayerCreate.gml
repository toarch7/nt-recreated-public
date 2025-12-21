/// @function scrPlayerCreate
/// @param player_index
/// @param {Enum.Race} race
/// @param skin_id
/// @param init_struct={}
function scrPlayerCreate(_index = 0, _race = Race.Random, _skin = 0, _struct = {}) {
    var player = instance_create_depth(10016, 10016, 0, Player, _struct)
	
	while _race == Race.Random {
		_race = irandom_range(Race.Fish, Race.NUM_ALL_RACE_TYPES - 1)
		
		if scr_race_is_unlocked(_race) {
			break
		}
	}
	
    with player {
        index = _index
		is_me = (_index == global.index)
        
        scrPlayerRaceChange(_race, _skin)
		
        hp = max_hp
        lsthealth = max_hp
    }
	
	scrAmmoInit()
	
    return player
}

function scrPlayerRaceChange(_race, _skin = -1) {
	race = _race
	
	if (_skin != -1) {
		bskin = _skin
	}
	else {
		_skin = bskin
	}
	
    max_hp = 8
    maxspeed = 4
    accuracy = 1
	veinsthreshold = 4
	cantoxic = true
	
    snd_hurt = scr_race_get_sound(_race, "Hurt", sndMutant1Hurt)
	snd_dead = scr_race_get_sound(_race, "Dead", sndMutant1Dead)
	snd_lowa = scr_race_get_sound(_race, "LowA", sndMutant1LowA)
	snd_lowh = scr_race_get_sound(_race, "LowH", sndMutant1LowH)
	snd_crwn = scr_race_get_sound(_race, "Crwn", sndMutant1Crwn)
	snd_chst = scr_race_get_sound(_race, "Chst", sndMutant1Chst)
	snd_wrld = scr_race_get_sound(_race, "Wrld", sndMutant1Wrld)
	snd_thrn = scr_race_get_sound(_race, "Thrn", sndMutant1Thrn)
	snd_valt = scr_race_get_sound(_race, "Valt", sndMutant1Valt)
	snd_spch = scr_race_get_sound(_race, "Spch", sndMutant1Spch)
	snd_cptn = scr_race_get_sound(_race, "Spch", sndMutant1Spch)
	
	var _sprite_skin = ((_race == Race.Rebel && _skin >= 2) ? _skin + 1 : _skin)
	spr_idle = scr_race_get_sprite(_race, "Idle", sprMutant1Idle, _sprite_skin)
	spr_walk = scr_race_get_sprite(_race, "Walk", sprMutant1Walk, _sprite_skin)
	spr_hurt = scr_race_get_sprite(_race, "Hurt", sprMutant1Hurt, _sprite_skin)
	spr_dead = scr_race_get_sprite(_race, "Dead", sprMutant1Dead, _sprite_skin)
	spr_gosit = scr_race_get_sprite(_race, "GoSit", sprMutant1GoSit, _sprite_skin)
	spr_sit = scr_race_get_sprite(_race, "Sit", sprMutant1Sit, _sprite_skin)
	spr_cry   = -1
	
	// force default dead sprite regardless of bskin
    if race == Race.Chicken {
        spr_dead = sprMutant9Dead
		if (_skin == SkinLetter.C) {
			spr_dead = sprMutant9CDead
		}
    }
	
	// Crystal can handle this
    if race == Race.Crystal max_hp = 10
    // Everything hurts
	else if race == Race.Melting max_hp = 2
	// Smart thoughts are always chasing him, but he is faster
    else if race == Race.Plant maxspeed = 4.5
	// Steroids used to be a scientist
    else if race == Race.Steroids {
        if !scr_weapon_is_valid(bwep) {
			bwep = wep_revolver
		}
		bcan_shoot = true
        accuracy = 1.8
    }
	// no words to say
	else if race == Race.BigDog {
        spr_idle = sprScrapBossIdle
        spr_walk = sprScrapBossWalk
        spr_hurt = sprScrapBossHurt
        spr_dead = sprScrapBossDead
        spr_gosit = sprScrapBossWalk
        spr_sit = sprScrapBossSleep
        max_hp = 300
        maxspeed = 2
        spr_shadow = shd96
        mask_index = mskScrapBoss
		scrPlayerGiveAmmo(id, Ammo.Bullets, 255)
		scrPlayerGiveAmmo(id, Ammo.Explosives, 44)
		veinsthreshold = (max_hp div 2)
        can_pick = 0
    }
	// Postmortal
    else if race == Race.Skeleton {
        maxspeed = 3
        accuracy = 1.5
        max_hp = 4
    }
	// Always believe in your soul
	else if race == Race.Frog {
		cantoxic = false
	}
	// It's ok to cry
	else if race == Race.Cuz {
		spr_cry = scr_race_get_sprite(_race, "Cry", sprMutant16Cry, _skin)
		max_extra_weps = 1
	}
	
	with scr_playerinstance_find(index) {
		race = _race
		skin = _skin
	}
	
	if scrCrownCheck(Crown.Death) max_hp -= 1
}




