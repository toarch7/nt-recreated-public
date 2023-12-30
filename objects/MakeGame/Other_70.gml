if async_load[? "type"] == "permissionStatus" {
	if async_load[? "success"] {
		if file_exists(".permissionlock")
			file_delete(".permissionlock")
	}
	else file_write(".permissionlock", "")
	
	alarm[0] = 1
}