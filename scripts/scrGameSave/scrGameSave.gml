function scrGameSave() {
    var b = buffer_create(1, buffer_grow, 1)

    // Various info
    var d = {
        area: GameCont.area,
        subarea: GameCont.subarea,
        loops: GameCont.loops,

        kills: GameCont.kills,

        hardmode: global.hardmode,

        daily: UberCont.daily_run,
        weekly: UberCont.weekly_run,

        ammo: undefined,
        hp: undefined,
        spirit: undefined,
		max_hp: undefined,
		recontuations: undefined,
		headloses: undefined
    }

    with Player {
        d.ammo = ammo
        d.hp = hp
        d.spirit = spirit
		d.max_hp = max_hp
		d.recontuations = recontuations
		d.headloses = headloses
    }

    buffer_write(b, buffer_string, json_stringify(d))

    // Save global variables
    var d = {}

    var keys = ["rng_state", "index", "seed", "is_server", "custom_seed", "hardmode", "time", "party_gun_dropped", "crownpick"]

    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i]

        d[$ key] = variable_global_get(key)
    }

    buffer_write(b, buffer_string, json_stringify(d))

    // Save GameCont
    with GameCont {
        var d = {}

        var keys = variable_instance_get_names(id)

        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i]

            var v = variable_instance_get(id, key)

            if key == "skills" {
                v = ds_list_write(v)
            }

            d[$ key] = v
        }

        buffer_write(b, buffer_string, json_stringify(d))
    }

    // Save playerinstances
    buffer_write(b, buffer_string, json_stringify(playerinstances))

    // Save player
    with Player
    if is_me {
        var d = {}

        var keys = variable_instance_get_names(id)

        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i]

            d[$ key] = variable_instance_get(id, key)
        }

        d[$ "image_speed"] = image_speed

        buffer_write(b, buffer_string, json_stringify(d))

        break
    }

    // Save persistent weapons
    var d = []

    with WepPickup {
        if persistent {
            array_push(d, wep)
        }
    }

    buffer_write(b, buffer_string, json_stringify(d))

    var c = buffer_compress(b, 0, buffer_get_size(b))

    buffer_save(c, "gamestate.dat")

    buffer_delete(b)
    buffer_delete(c)
}