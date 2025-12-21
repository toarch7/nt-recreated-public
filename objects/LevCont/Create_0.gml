scrLetterbox(true)

random_set_seed(global.seed)

var _destiny = scrCrownCheck(crwn_destiny)

for(var i = 0; i <= 15; i ++) mutseed[i] = irandom(999999)

random_set_seed(mutseed[(GameCont.level - GameCont.skillpoints)] + GameCont.wasskeleton * 10203)

wave = 0
view_xview = 0
view_yview = 0
placeonpatience = 0
splatimg = 0

if GameCont.patiencepick {
	random_set_seed(global.seed + 200513)
	GameCont.patiencepick = 0
	placeonpatience = 1
}

if GameCont.codpick {
	random_set_seed(global.seed + 808081)
	GameCont.codpick = false
}

if GameCont.area == area_jungle && GameCont.skillpoints == 1 {
	global.seed += 15013
	for(i = 0; i <= RNGStates.NUM_RNG_STATES; i ++) {
		global.rng_state[i] = global.seed
	}
	random_set_seed(global.seed)
}

if GameCont.crownpoints > 0 {
	scrCrowns()
	
	var _crowns = [ crwn_none ]
	
	if !GameCont.loops {
		array_push(_crowns, crwn_life, crwn_guns, crwn_haste, crwn_destiny, crwn_curses, crwn_risk)
	}
	else {
		array_push(_crowns, crwn_death, crwn_hatred, crwn_blood, crwn_love, crwn_luck, crwn_protection)
	}
	
	var _x = view_xview + view_width / 2,
		_y = view_yview + view_height - 20
	
	var _count = array_length(_crowns)
	_x -= (_count - 1) * 16
	
	for(var i = 0; i < _count; i ++) {
		with instance_create(_x, _y, CrownIcon) {
			crown = _crowns[i]
			num = i
		}
		
		_x += 32
	}
	
	with CrownIcon {
		creator = other.id
	}
}
else if GameCont.skillpoints {
	scrSkills()
	
	var _maxskills = _destiny ? 1 : 4
	_maxskills += scrPlayerCountRace(Race.Horror)
	
	var _num = 0
	
	repeat _maxskills {
		var _skill = scrDecideSkill(_num == 0)
		
		if (!scr_skill_is_valid(_skill)) break
		
		with instance_create(0, 0, SkillIcon) {
			skill = _skill
			num = ++_num
        }
	}
	
	if !scr_skill_get(mut_heavy_heart) && !GameCont.wantheavy && GameCont.heavyheart >= 3 {
		if instance_exists(SkillIcon) {
			with instance_find(SkillIcon, 0) {
				skill = mut_heavy_heart
			}
			
			GameCont.wantheavy = 1
		}
	}
}
else if GameCont.ultrapoints {
    if (player_count > 1) {
		var _coop_ultra_need = true
		
		for(var i = 0; i < player_count; ++i) {
			var _pinst = scr_playerinstance_find(i)
			if (scr_ultra_get_from_race(_pinst.get_race() != -1)) {
				_coop_ultra_need = false
				break
			}
		}
		
		if (_coop_ultra_need) {
			with instance_create(0, 0, UltraIcon) {
				race = Race.CoopUltra
				num = 1
			}
			with instance_create(0, 0, UltraIcon) {
				race = Race.CoopUltra
				num = 2
			}
		}
	}
	
    with (instance_create(0, 0, UltraIcon)) num = 1
    with (instance_create(0, 0, UltraIcon)) num = 2
	
	// the race of UltraIcon is decided within UltraIcon create event
	var _any_horror = false
	with (UltraIcon) {
		if (race == Race.Horror) _any_horror = true
	}
	
	// ultra C
    if (_any_horror) {
		with (instance_create(0, 0, UltraIcon)) num = 3
	}
	
    if scrCrownCheck(crwn_destiny) && !UberCont.opt_griller {
		var _maxskills = 1 + scrPlayerCountRace(Race.Horror)
		
        while (instance_number(UltraIcon) > _maxskills) {
			instance_destroy(instance_random(UltraIcon))
		}
	}
}

if UberCont.daily_run && UberCont.april_fools {
    with SkillIcon {
        skill = mut_open_mind
    }
    
	if instance_exists(UltraIcon) {
		GameCont.skillpoints ++
		GameCont.ultrapoints = 0
	}
	
    with UltraIcon {
        with instance_create(x, y, SkillIcon) {
            skill = mut_open_mind
            num = other.num
        }
        
        instance_destroy()
    }
    
    with CrownIcon {
        with instance_create(x, y, SkillIcon) {
            skill = mut_open_mind
            num = other.num
        }
        
        instance_destroy()
    }
}

splat = 0
appear = view_height / 2

grillpage = -1
grillpadchange = 0
overgrilled = false

event_user(0)

if instance_exists(SkillText) {
	with (SkillText) y -= 40
	appear = 0
}