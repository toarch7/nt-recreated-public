/// @function scrProjectPath
/// @param location
function scrProjectPath(_location) {
	if (!(os_type == os_windows || os_type == os_linux || os_type == os_macosx)) {
		return _location
	}
	
	if (GM_build_type == "run" && !(GM_is_sandboxed || global.__disable_sandboxing)) {
		return filename_path(GM_project_filename) + "datafiles/" + _location
	}
	
	return working_directory + _location
}