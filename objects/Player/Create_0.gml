event_inherited()
can_pick = 1
can_die = 1

active_button_forever = 0

alarm[10] = 10
friction = 0.45
image_speed = 0.4

recontinues = 0

pref = function(name) {
	var p = player_get(index)
	
	if p == undefined
		exit
	
	return player_pref(p, name)
}

crosshair_x = x
crosshair_y = y

crosshair_alpha = 0

#macro PRACTICE_FAINTED_TIME (45 * 30)
fainted = false