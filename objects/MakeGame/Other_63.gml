if async_load[? "id"] == message {
    if !IsVersionR() {
		os_request_permission("android.permission.WRITE_EXTERNAL_STORAGE")
		alarm[0] = 30
	}
	else RequestPermission()
}