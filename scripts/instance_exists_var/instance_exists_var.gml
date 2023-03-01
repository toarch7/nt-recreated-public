function instance_exists_var(obj, name, val) {
	with obj {
		if self[$ name] == val {
			return id
		}
	}
	
	return noone
}