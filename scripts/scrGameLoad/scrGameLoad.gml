function scrGameLoad() {
	exit
	
    try {
        var c = buffer_load("gamestate.dat")
        var b = buffer_decompress(c)

        var d = json_parse(buffer_read(b, buffer_string)) // info
        UberCont.daily_run = d.daily
        UberCont.weekly_run = d.weekly

        var a = json_parse(buffer_read(b, buffer_string)) // globals
        var keys = struct_keys(a)

        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i]

            variable_global_set(key, a[$ key])
        }

        delete a

        var a = json_parse(buffer_read(b, buffer_string)) // gamecont

        var keys = struct_keys(a)

        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i]

            with GameCont {
                if key == "skills" {
                    ds_list_read(skills, a[$ key])
                } else self[$ key] = a[$ key]
            }
        }

        delete a
		
		var pinstlist = json_parse(buffer_read(b, buffer_string))
		
        global.__playerinstance_list = {} // global.__playerinstance_list
		
		scr_playerinstances_load_from_list(pinstlist)
		
		my_player = scr_playerinstance_find()
		
        var a = json_parse(buffer_read(b, buffer_string)) // player

        var keys = struct_keys(a)

        player_count = 0

        with Player {
            for (var i = 0; i < array_length(keys); i++) {
                self[$ keys[i]] = a[$ keys[i]]
            }

            player_count++

            hp = d.hp
            ammo = d.ammo
            spirit = d.spirit
            max_hp = d.max_hp
            headloses = d.headloses

            break
        }

        delete a

        var a = json_parse(buffer_read(b, buffer_string)) // weapons

        if array_length(a) {
            for (var i = 0; i < array_length(a); i++) {
                with instance_create(10016, 10016, WepPickup) {
                    ammo = 0
                    wep = a[i]
                    name = wep_name[wep]
                    type = wep_type[wep]
                    sprite_index = wep_sprt[wep]
                    image_angle = random_angle
                    mask_index = mskNone
                    persistent = 1
                    visible = 0
                }
            }
        }
		
		scrWeapons()

        scrRngStatesReset()

        buffer_delete(c)
        buffer_delete(b)

        return 1
    }
	catch (e) {
        print_error(e.longMessage, 1)

        buffer_delete(c)
        buffer_delete(b)

        return 0
    }
}