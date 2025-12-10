var _current_object = array_first(list)

if instance_exists(GenCont) self.reset()

if is_undefined(_current_object) {
	print("Test finished.")
	instance_destroy()
	
	exit
}

if instance_exists(damagesource) {
	duration ++
	
	if duration >= (500) {
		print("WARN! test for",
			object_get_name(_current_object),
			"was taking way too long")
		
		with damagesource {
			print("    destroying", id, x, y, "distance:", , distance_to_point(10016, 10016))
			instance_destroy(id, false)
		}
	}
}
else if projectile_created {
	array_shift(list)
	self.reset()
}
else {
	print("Running test for", object_get_name(_current_object), array_length(list))
	
	with Player {
		can_die = false
		
		if object_is_ancestor(_current_object, projectile) {
			scr_projectile_create(x, y, _current_object, 0, 4)
			continue
		}
		
		var _target = instance_random(enemy),
			_tx = _target ? _target.x : 10016,
			_ty = _target ? _target.y : 10016
		
		scr_damage_create(_tx, _ty, _current_object)
	}
	
	projectile_created = true
}
