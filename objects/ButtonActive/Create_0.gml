x = view_width + (global.view_width_max - view_width) / 2 - 64
y = view_height / 2 - 48

event_inherited()

rad = 25

melting = 0

button_name = "ABILTIY BUTTON"

time = 0

do_thing = 0

rogue_touch = -1
rogue_hide = 180

can_forever = function (player) {
	if !instance_exists(player)
		return false
	
	var pinst = player_get()
	
	return (player.race == 3 && player_pref(pinst, "eyes"))
		or (player.race == 4 && player_pref(pinst, "melting"))
		or (player.race == 6 && player_pref(pinst, "yv"))
		or (player.race == 14 && player_pref(pinst, "skeleton"))
		or (player.race == 7 && player_pref(pinst, "steroids"))
		or (player.race == 12 && !player_pref(pinst, "rogue"))
		or (player.race == 11)
}