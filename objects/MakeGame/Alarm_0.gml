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
            message = show_message_async("Эта игра требует доступ к внешнему хранилищу для записи и чтения прогресса.\nВы можете отозвать его в настройках приложения при возникновении каких-либо неполадок с игровыми данными.")
        } else {
            message = show_message_async("This game requires external storage access permission to store files.\nYou can disable it in application settings in case of game data issues.")
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

randomize()

instance_create(0, 0, UberCont)

if loading {
    c = buffer_load("gamestate.dat")
    b = buffer_decompress(c)

    scrUltras()

    try {
        var d = json_parse(buffer_read(b, buffer_string)) // extra info
        global.hardmode = d.hardmode

        var a = buffer_read(b, buffer_string) // globals (skip)
        scrGameSaveInfo()

        UberCont.daily_run = d.daily
        UberCont.weekly_run = d.weekly

        cont = json_parse(buffer_read(b, buffer_string)) // gamecont

        UberCont.playerinstances = json_parse(buffer_read(b, buffer_string)) // playerinstances duh

        player = json_parse(buffer_read(b, buffer_string)) // player

        with player {
            hp = d.hp
            ammo = d.ammo
            spirit = d.spirit
        }

        show_debug_message(cont)

        pos = max(cont.waypoints - 15, 0)

        skills = ds_list_create()
        ds_list_read(skills, cont.skills)

        KeyCont.players = 1

        instance_create(0, 0, SpiralCont)
        depth = -1000
    } catch (e) {
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
} else room_goto(romGame)