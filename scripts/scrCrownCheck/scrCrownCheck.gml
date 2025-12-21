/// @function scrCrownCheck
/// @param crown_id
function scrCrownCheck(_crown) {
	with (GameCont) return (crown == _crown)
}

/// @function scrCrownSetCurrent
/// @param crown_id
/// @param is_start_crown=false
function scrCrownSetCurrent(_crown, _is_start_crown = false) {
	with (GameCont) {
		// unequip old crown
		scrCrownApplyEquipEffect(crown, false)
		
		crown = _crown
		if _is_start_crown {
			global.crownpick = _crown
		}
		
		// equip the new one
		if (instance_exists(Player)) {
			scrCrownApplyEquipEffect(_crown, true)
		}
	}
	
	var _player = noone
	
	with Player {
		if (index == 0) _player = id
	}
	
	if _crown != crwn_none && instance_exists(_player) {
		if !instance_exists(CrownObject) {
			instance_create(_player.x, _player.y, CrownObject)
		}
		
		with CrownObject {
			event_perform(ev_alarm, 2)
		}
	}
	else {
		instance_destroy(CrownObject)
	}
}

function scrCrownGetCurrent() {
	with GameCont {
		return crown
	}
	
	return crwn_none
}