x = view_width + (global.view_width_max - view_width) / 2 - 64
y = view_height / 2 - 48

event_inherited()

rad = 25

melting = 0

button_name = "ABILTIY BUTTON"

time = 0

do_thing = 0

rogue_touch = -1

can_forever = function (player) {
	if !instance_exists(player)
		return false
	
	var pinst = playerinstance_get()
	
	return (player.race == 3 && pinst.pref("eyes"))
		or (player.race == 4 && pinst.pref("melting"))
		or (player.race == 6 && pinst.pref("yv"))
		or (player.race == 14 && pinst.pref("skeleton"))
		or (player.race == 7 && pinst.pref("steroids"))
		or (player.race == 12 && !pinst.pref("rogue"))
		or (player.race == 11)
}