function dll_check(name) {
	if os_type != os_windows
		return false
	
	return file_exists("./" + name + ".dll")
		or file_exists("./" + name + "_x64.dll")
		or file_exists(working_directory + name + ".dll")
		or file_exists(working_directory + name + "_x64.dll")
	
}