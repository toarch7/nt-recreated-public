/// @function scrUltraCheck
/// @param {Enum.Race|Real} race_id
/// @param {Enum.UltraSkill|Real} ultra_id
function scrUltraCheck(_race, _ultra) {
	with GameCont {
		if _race == Race.CoopUltra {
			return coopultra == _ultra
		}
		
		// TODO: refactor to support multiple ultras
		if race == _race {
			return ultra == _ultra
		}
	}
	
	return 0
}

/// @function scrUltraCheckPlayerRace
/// @param player
/// @param {Real|Enum.Race} race_id
/// @param {Real|Enum.UltraSkill} ultra_id
function scrUltraCheckPlayerRace(_player, _race, _ultra) {
	if (instance_exists(_player)) {
		assert(instance_is(_player, Player), "`player_instance` must be a valid Player object instance")
		if (_player.race == _race) {
			
			// TODO: refactor to support multiple ultras
			if GameCont.ultra == _ultra {
				return true
			}
			//return GameCont.ultra[_ultra]
		}
	}
	return 0
}