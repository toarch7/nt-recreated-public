function android_check_storage_permission() {
	if os_type != os_android
		return os_permission_denied
	
	if IsVersionR() {
		if file_exists(".permissionlock")
			return os_permission_denied_dont_request
		
		return CheckPermission()
	}
	
	return os_check_permission("android.permission.WRITE_EXTERNAL_STORAGE")
}

function android_check_any_local_files() {
	var list = directory_read("*")
	print("Local files found:", list)
	return array_length(list) > 0
}