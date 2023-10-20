function scrEraseProgress() {
    with UberCont {
        var _seed = save_get_value("etc", "seed", - 1)

        ds_map_destroy(saveData)
        saveData = ds_map_create()

        saveData[? "etc_seed"] = _seed

        var f = file_text_open_write(game_directory + "NuclearThrone.sav")
        file_text_write_string(f, "{}")
        file_text_close(f)

        dont_save = 1
    }

    with all {
        if object_index != Console instance_destroy(id, 0)
    }

    room_goto(romInit)
}