function instance_exists_var(obj, name, val) {
	with obj {
		if self[$ name] == val {
			return id
		}
	}
	
	return noone
}

function instance_exists_var_notme(obj, name, val) {
	with obj {
		if id != other.id && self[$ name] == val {
			return id
		}
	}
	
	return noone
}