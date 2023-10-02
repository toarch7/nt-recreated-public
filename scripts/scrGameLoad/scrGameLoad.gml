function scrGameLoad() {
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
		
		var pinstlist = json_parse(buffer_read(b, buffer_string)),
			pinstkeys = struct_keys(pinstlist)
		
        playerinstances = {} // playerinstances
		
		for(var i = 0; i < array_length(pinstkeys); i ++) {
			var p = pinstlist[$ pinstkeys[i]],
				pinst = new PlayerInstance(p.index)
			
			var keys = struct_keys(p)
			
			for(var k = 0; k < array_length(keys); k ++) {
				var key = keys[k],
					val = p[$ key]
				
				pinst[$ key] = val
			}
			
			playerinstances[$ p.index] = pinst
		}
		
		playerinstance = playerinstance_get()
		
        var a = json_parse(buffer_read(b, buffer_string)) // player

        var keys = struct_keys(a)

        KeyCont.players = 0

        with Player {
            for (var i = 0; i < array_length(keys); i++) {
                self[$ keys[i]] = a[$ keys[i]]
            }

            KeyCont.players++

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
                    image_angle = random(360)
                    mask_index = mskNone
                    persistent = 1
                    visible = 0
                }
            }
        }

        rng_reset()

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