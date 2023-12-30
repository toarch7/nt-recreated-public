if instance_exists(UberCont) {
    with UberCont
		scrSetViewSize()
	
    instance_destroy()
    room_goto(romGame)
	
    exit
}

var check = false

if os_type == os_android {
    check = android_check_storage_permission()
	
    //if check == os_permission_denied or request_perm {
	if request_perm {
		var str = "The game requires access to read and write files for customization" +
				  "and to save your progress.\nYou can revoke this permission in the System " +
				  "Preferences if you experience problems with your game data."
		
		if legacy {
			str = "A previous installation of the game has been detected. Due to recent internal " +
			      "API migrations, you must grant the application permission to access your file " +
				  "system in order to preserve savefile progress." + 
				  "\n\nYou can do this now, then revoke it later and all your data will be kept."
		}
		
		message = show_message_async(loc(str))
		
        request_perm = false
        alarm[0] = -1

        exit
    }
}

if alarm[0] > 0
    exit

if os_type == os_android && check {
    game_directory = "/sdcard/games/com.toncho.nuclearthrone/files/"

    if !directory_exists(game_directory) {
        directory_create(game_directory)
    }
}
else game_directory = ""

playerinstance = undefined
instance_create(0, 0, UberCont)

//
	var info = os_get_info(),
		udid = scrGenerateUID(info[? "udid"])
	
	save_set_value("general", "uid", udid)
	
	ds_map_destroy(info)
//

randomize()

if loading {
    gamestatebuffer_c = buffer_load("gamestate.dat")
    gamestatebuffer = buffer_decompress(gamestatebuffer_c)
	
	var buff = gamestatebuffer_c
	
    scrUltras()
	scrVolume()

    try {
        var d = json_parse(buffer_read(buff, buffer_string)) // extra info
        global.hardmode = d.hardmode

        var a = buffer_read(buff, buffer_string) // globals (don't need)
        scrGameSaveInfo()

        UberCont.daily_run = d.daily
        UberCont.weekly_run = d.weekly

        cont = json_parse(buffer_read(buff, buffer_string)) // gamecont

        playerinstances = json_parse(buffer_read(buff, buffer_string)) // playerinstances

        player = json_parse(buffer_read(buff, buffer_string)) // player

        with player {
            hp = d.hp
            ammo = d.ammo
            spirit = d.spirit
			
			//
			self[$ "fainted"] ??= 0
        }
		
        pos = max(cont.waypoints - 15, 0)

        skills = ds_list_create()
        ds_list_read(skills, cont.skills)

        KeyCont.players = 1

        instance_create(0, 0, SpiralCont)
		
        depth = -1000
    }
	catch (e) {
        print_error("Failed to load gamestate:\n" + e.longMessage, 1)

        if file_exists("m_gamestate.dat") {
            file_delete("m_gamestate.dat")
        }

        file_rename("gamestate.dat", "m_gamestate.dat")

        with UberCont
			instance_destroy()

        instance_destroy()
		
		instance_activate_all()
		
        room_restart()
    }
}
else {
	if save_get_value("etc", "disclaimer", 0) {
		room_goto(romGame)
	}
	else disclaimer = 1
}