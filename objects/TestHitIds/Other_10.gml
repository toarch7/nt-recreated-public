if (instance_exists(GenCont)) {
	scr_test_create_arena(5, false)
}

with (Portal) instance_destroy()

if (duration <= 0) {
	if (array_length(list) == 0) {
		show_debug_message("the list is exhausted!")
		show_debug_message(json_stringify(result, true))
		draw_enable_drawevent(true)
		instance_destroy()
		exit
	}
	
	if (!setup) {
		if (variable_struct_names_count(projectile_hitids) == 0) {
			show_debug_message("no hitids were registered")
		}
		else {
			show_debug_message("hitid results:")
		}
		
		struct_foreach(projectile_hitids, function(_key, _value) {
			show_debug_message("      object=" + string(_key) + ", hitid = " + string(_value))
		})
		
		if (variable_struct_exists(result, name)) {
			show_debug_message("warn: overwriting hitid results for", name)
		}
		
		result[$ name] = projectile_hitids
		
		projectile_hitids = {}
	}
	else {
		if (!debug_hitid_testing) {
			print("`debug_hitid_testing` configuration isn't on. some hit ids might not register")
		}
		setup = false
	}
	
	scr_test_create_arena(5, false)
	
	print("------------------------------------------------")
	
	var _object = array_pop(list)
	name = object_get_name(_object)
	
	print("List size:", array_length(list), "| Next object:", name)
	
	instance_create(10016, 10016, _object)
	
	duration = 1800
	
	if (object_is_ancestor(_object, prop)) duration = 300
}

duration --

if (instance_exists(Player)) {
	with (Player) {
		hp = 10_000
		lsthealth = hp
		if (distance_to_point(10016, 10016) > 130) {
			motion_add(point_direction(x, y, 10016, 10016), 1)
		}
		if (instance_exists(prop) && !instance_exists(enemy)) {
			x = prop.x
			y = prop.y
		}
	}
	
	with (enemy) {
		if (current_frame % 4 >= 2) {
			for(var i = 0; i < 11; ++i) {
				if (alarm[i] > 1) alarm[i] --
			}
		}
		
		if (meleedamage != 0 && (current_frame % 450) < 90
			&& !variable_struct_exists(other.projectile_hitids, object_get_name(object_index))
		) {
			x += ldrx(4, point_direction(x, y, Player.x, Player.y))
			y += ldry(4, point_direction(x, y, Player.x, Player.y))
		}
	}
	
	if ((duration % 60) == 0) {
		// damage enemies over time to trigger behaviours related with health
		with (enemy) if (other.duration < 300 || hp > 1) {
			scr_hit(id, max(1, ceil(max_hp * 0.05)), HitId.Player)
			if (other.duration < 300 && hp < 1) hp = 1
		}
		with (prop) scr_hit(id, 1, HitId.Player)
	}
}

with (damagesource) {
	var _name = object_get_name(object_index)
	
	if (variable_struct_exists(other.projectile_hitids, _name)) {
		continue
	}
	
	other.projectile_hitids[$ _name] = scrDeathCauseGetName(hitid)
	print("registered hit from", _name, "as", scrDeathCauseGetName(hitid), hitid)
}