if async_load[? "id"] == message {
    if !IsVersionR() {
		os_request_permission("android.permission.WRITE_EXTERNAL_STORAGE")
	}
	else RequestPermission()
	
	alarm[0] = 1
}