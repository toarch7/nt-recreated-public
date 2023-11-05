if instance_exists(UberCont) {
    with UberCont
		scrSetViewSize()
	
    instance_destroy()
    room_goto(romGame)
	
    exit
}

var check = 0

if os_type == os_android {
    check = os_check_permission("android.permission.WRITE_EXTERNAL_STORAGE")

    if check == os_permission_denied or firstry {
        if os_get_language() == "ru" { //ah yes, haяdcoded localisations
            message = show_message_async("Игра требует доступ к чтению и записи файлов для кастомизации и сохранения прогресса.\nВы можете отозвать разрешение в настройках системы при возникновении неполадок с игровыми данными.")
        }
		else {
            message = show_message_async("The game requires access to read and write files for customization and progress saving.\nYou can revoke the permission in the system settings if there are any issues with game data.")
        }

        alarm[0] = -1
        firstry = 0

        exit
    }
}

if alarm[0] > 0 {
    exit
}

if os_type == os_android && check == os_permission_granted {
    game_directory = "/sdcard/games/com.toncho.nuclearthrone/files/"

    if !directory_exists(game_directory) {
        directory_create(game_directory)
    }
} else game_directory = ""

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
    c = buffer_load("gamestate.dat")
    b = buffer_decompress(c)

    scrUltras()
	
	scrVolume()

    try {
        var d = json_parse(buffer_read(b, buffer_string)) // extra info
        global.hardmode = d.hardmode

        var a = buffer_read(b, buffer_string) // globals (don't need)
        scrGameSaveInfo()

        UberCont.daily_run = d.daily
        UberCont.weekly_run = d.weekly

        cont = json_parse(buffer_read(b, buffer_string)) // gamecont

        playerinstances = json_parse(buffer_read(b, buffer_string)) // playerinstances

        player = json_parse(buffer_read(b, buffer_string)) // player

        with player {
            hp = d.hp
            ammo = d.ammo
            spirit = d.spirit
			
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