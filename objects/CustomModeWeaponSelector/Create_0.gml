event_inherited()

group_count = Ammo.NUM_AMMO_TYPES + 1

groups = array_create(group_count)
group_names = array_create(group_count)
choosing_secondary = false
choosing_proto = false
hovered_weapon = -1
tooltip_pop = 0
setup = true

get_weapon_key = function() {
	if (choosing_secondary) return "bwep"
	if (choosing_proto) return "protowep"
	return "wep"
}

get_curse_key = function() {
	if (choosing_secondary) return "bcurse"
	if (choosing_proto) return "protocurse"
	return "curse"
}

height = 0

name = loc("CustomMode.Weapon:Caption", "WEAPON")