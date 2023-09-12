function load_custom_sounds(path) {
    var status = 0

    if !file_exists(path + ".nomedia") {
        var f = file_text_open_write(path + ".nomedia")
        file_text_write_string(f, "")
        file_text_close(f)
    }
	
	var _find = files_find_all(path + "*.ogg")
	
    for(var i = 0; i < array_length(_find); i ++) {
		var find = _find[i]
		
        if find != "musThemeB.ogg" && string_copy(find, 1, 7) != "musBoss" && string_copy(find, 1, 3) == "mus" {
            find = string_replace(find, "B.ogg", "b.ogg")
        }

        var asset = asset_get_index(string_replace(find, ".ogg", ""))

        if audio_exists(asset) {
            var stream = audio_create_stream(path + find)

            if stream {
                global.customSounds[$ string(asset)] = stream
            } else {
                print("!!! Unable to create audio stream for", find);
                status = 1
            }
        } else {
            print("!!! Unable to find sound in game: ", find);
            status = 1
        }

        find = file_find_next()
    }

    file_find_close()

    return status
}