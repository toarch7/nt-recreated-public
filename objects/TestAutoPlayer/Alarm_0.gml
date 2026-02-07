/// @description Randomize player loadout & skills
with (Player) {
	var _r, _last_race = race;
	
	max_extra_weps = 0
	scrExtraWepsReset()
	
	if (global.__debug_autoplayer_race == Race.Random) {
		do {
			_r = irandom_range(Race.Fish, Race.NUM_ALL_RACE_TYPES - 1)
		}
		until (_r != Race.BigDog && race != _r && (!scrRaceIsHidden(_r) || random(1) < 0.3))
		
		scrPlayerRaceChange(_r)
	}
	else if (race != global.__debug_autoplayer_race) {
		scrPlayerRaceChange(global.__debug_autoplayer_race)
	}
	
	wep = scrDecideWep(1)
	bwep = scrDecideWep(1)
	
	hp = max_hp
	
	scrPlayerGiveAmmo(id, scr_weapon_get_type(wep), 255)
	scrPlayerGiveAmmo(id, scr_weapon_get_type(bwep), 255)
	
	if (!other.ultra) {
		var _ultra = scr_ultra_get_from_race(_last_race)
		if (_ultra >= 0) scr_ultra_set(_last_race, _ultra, 0)
		
		var _m = race == Race.Horror ? 3 : 2
		scr_ultra_set(race, irandom_range(1, _m), 1)
	}
}

with (GameCont) {
	var _str = scrAreaGetMapName(area, subarea, loops, scrGameIsHardmode(), false)
	window_set_caption(_str)
	print("Entered", _str)
}

var _mut_count = max(GameCont.level, ds_list_size(GameCont.skills))

scr_skills_clear()

var _new_muts = array_shuffle(range(1, maxskill))
repeat (_mut_count) {
	var _skill = array_shift(_new_muts)
	if (scr_skill_is_valid(_skill) && scr_skill_can_appear(_skill)) {
		scr_skill_set(_skill, 1)
	}
}

ultra = false