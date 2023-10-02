function load_resourcepacks_from(loadpath) {
    var status = 0
	
    print("Loading resourcepacks at " + loadpath)
	
    var list = []
	
    var f = file_find_first(loadpath + "*", fa_directory)
	
    while f != "" {
        array_push(list, f)
        f = file_find_next()
    }
	
    file_find_close()
	
    for (var i = 0; i < array_length(list); i++) {
        var local = 0,
            status = 0
		
		if !global.console_active {
			global.log_output = []
	        global.log_color = []
		}
		
        var _name = list[i]
		
        print("Loading pack \"" + _name + "\"")

        var packdir = loadpath + _name + "/",
			metafile = packdir + "meta.json",
			
			pack = {},
			info = {}
		
        try {
            pack = json_parse(file_read(metafile))
			
            pack[$ "name"] ??= _name
            pack[$ "descriptionShort"] ??= ""
            pack[$ "description"] ??= ""
        }
		catch (e) {
			if file_exists(metafile)
				file_rename(metafile, packdir + "M_meta.json")
			
            printc("! meta.json is malformed or doesn't exist. Generating template...", c_yellow)

	        pack[$ "name"] = _name
	        pack[$ "descriptionShort"] = scrGetUsername() + "'s resourcepack"
	        pack[$ "description"] = "No extra information were specified. This is a template file generated by the game."
			
			file_write(packdir + "meta.json", json_stringify(pack))
        }
		
		if file_exists(packdir + "githubdata.json") {
		    try {
		        info = json_parse(file_read(packdir + "githubdata.json"))
		    }
			catch (e) {
		        printc("[!] githubdata.json parse failed: " + e.message, c_yellow)
		    }
		}
		else local = true
		
        pack[$ "id"] = _name
		pack[$ "path"] = packdir
		pack[$ "external"] = !local
		
		pack.promoted = false
		
		pack.full_name = info[$ "full_name"] ?? ("local/" + _name)
		pack.owner = info[$ "owner"] ?? "local"
		pack.created = info[$ "created"] ?? unix_timestamp()
		pack.updated = info[$ "updated"] ?? unix_timestamp()
		pack.installtime = info[$ "installtime"] ?? 0
		pack.stars = info[$ "stars"] ?? 0
		pack.priority = info[$ "priority"] ?? 0
		
		pack.hasIcon = file_exists(packdir + "icon.png")
		
        var active = !file_exists(packdir + "disable.d")
		
        pack[$ "active"] = active
		
        if active {
            if directory_exists(packdir + "usersprites")
				status += load_custom_sprites(packdir + "usersprites/")

            if directory_exists(packdir + "usersounds")
				status += load_custom_sounds(packdir + "usersounds/")

            if directory_exists(packdir + "localizations")
				status += load_custom_locales(packdir + "localizations/")

            if file_exists(packdir + "areacolors.json")
				status += load_custom_area_colors(packdir + "areacolors.json")

            if file_exists(packdir + "shadowcolors.json")
				status += load_custom_shadow_colors(packdir + "shadowcolors.json")
        }
		
        array_push(Resourcepacks, pack)
		
        if local && status > 0 {
            var str = "Something went wrong:\n\n"
			
            for (var j = 0; j < array_length(global.log_output); j ++)
                str += global.log_output[j] + "\n"
			
            if global.desktop {
				 if !instance_exists(Console)
					instance_create(0, 0, Console)
	
                global.console_active = true
			}
			else show_message_async(str)
        }
    }
}