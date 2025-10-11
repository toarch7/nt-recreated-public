/// @description Update icon statuses
if weekly exit

var _instances = global.__playerinstance_list

for (var i = 0; i < player_count; i++) {
    var _pinst = _instances[i]
	
	if instance_exists(CoopController) {
		_pinst.reset_loadout()
		continue
	}
	
    with CharSelect {
	    if race && race == _pinst.race {
	        event_perform(ev_mouse, ev_left_press)
			break
		}
    }
}
