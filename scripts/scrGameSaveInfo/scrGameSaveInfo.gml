function scrGameSaveInfo() {
    // loads, updates and saves extra info
    // (especially player's ammo and health to prevent cheating) 

    if !file_exists("gamestate.dat") exit

    try {
        var c = buffer_load("gamestate.dat") // compressed
        var b = buffer_decompress(c)

        var d = json_parse(buffer_read(b, buffer_string)) // save buff

        with Player {
            d.hp = min(d.hp, hp)

            for (var i = 0; i < array_length(ammo); i++) {
                if ammo[i] < d.ammo[i] {
                    d.ammo[i] = ammo[i]
                }
            }

            if !spirit {
                d.spirit = spirit
            }
        }

        // rebuild the buffer
        var s = buffer_create(1, buffer_grow, 1)
        buffer_write(s, buffer_string, json_stringify(d)) // info
        buffer_write(s, buffer_string, buffer_read(b, buffer_string)) // globals
        buffer_write(s, buffer_string, buffer_read(b, buffer_string)) // gamecont
        buffer_write(s, buffer_string, buffer_read(b, buffer_string)) // pinstances
        buffer_write(s, buffer_string, buffer_read(b, buffer_string)) // player
        buffer_write(s, buffer_string, buffer_read(b, buffer_string)) // weps

        // save
        buffer_delete(c)
        c = buffer_compress(s, 0, buffer_get_size(s))
        buffer_save(c, "gamestate.dat")

        buffer_delete(c)
        buffer_delete(b)
        buffer_delete(s)
    } catch (e) {
        buffer_delete(b)
        buffer_delete(c)
        buffer_delete(s)

        print_error(e.longMessage, 1)
    }
}