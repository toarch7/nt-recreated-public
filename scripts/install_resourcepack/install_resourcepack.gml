function install_resourcepack(file) {
	var dest = game_directory + "resourcepacks/"
	
	if os_type == os_android
		return ResourcepackInstall(file, dest)
	
	
	// ew
	
	var installdir = game_directory + "install/"
	
	if !directory_exists(installdir)
		directory_create(installdir)
	
	var list_pre = directory_read(installdir + "*", fa_directory)
	
	var z = zip_unzip(file, installdir)
	
	if z <= 0
		return -1
	
	var list_post = directory_read(installdir + "*", fa_directory)
	
	var diff = array_diff(list_post, list_pre)
	
	print(list_pre, list_post)
	print("New install directories:", diff)
	
	if array_length(diff) > 1 {
		with ResourcepackManager
			error = "SOMETHING WENT WRONG..."
		
		print("More than 1 new folder extracted. Huh??")
		
		exit
	}
	
	if !array_length(diff) {
		with ResourcepackManager
			error = "DOWNLOAD FAILURE#OR PACK IS ALREADY INSTALLED."
		
		exit
	}
	
	with ResourcepackManager
		error = "FAILED TO EXTRACT:"
	
	var pack_name = diff[0],
		path = installdir + pack_name + "/",
		dest_path = dest + "/" + pack_name + "/",
		failures = 0
	
	if directory_exists(dest_path)
		directory_destroy_recursive(dest_path)
	
	var folders = [ "usersprites", "usersounds", "localizations" ];
	
	for(var i = 0; i < array_length(folders); i ++) {
		var filename = folders[i],
			_zip = path + filename + ".zip"
		
		if file_exists(_zip) {
			var z = zip_unzip(_zip, path)
			
			if !z {
				failures ++
				
				with ResourcepackManager
					error += "\n" + filename
				
				continue
			}
			else {
				file_delete(_zip)
			}
		}
	}
	
	if !failures {
		directory_move_files(installdir + pack_name, dest_path)
		
		for(var i = 0; i < array_length(folders); i ++) {
			var filename = folders[i]
			
			if directory_exists(path + filename)
				directory_move_files(path + filename, dest_path + filename)
		}
		
		with ResourcepackManager {
			var map = ds_map_create()
			map[? "type"] = "unzip"
			map[? "entry"] = dest_path
			
			event_perform_async(ev_social, map)
			
			error = ""
		}
	}
	
	directory_destroy_recursive(game_directory + "install")
}