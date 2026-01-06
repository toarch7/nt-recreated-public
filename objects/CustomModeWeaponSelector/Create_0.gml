event_inherited()

group_count = Ammo.NUM_AMMO_TYPES + 1

groups = array_create(group_count)
group_names = array_create(group_count)
choosing_secondary = false
choosing_proto = false

event_user(1)

update_selection = function() {
	
}

height = 500