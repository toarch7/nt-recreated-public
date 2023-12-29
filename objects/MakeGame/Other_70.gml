show_message_async(json_encode(async_load))

if async_load[? "type"] == "permissionStatus" {
	if !async_load[? "success"]
		file_write(".permissionlock", "")
}