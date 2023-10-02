function load_custom_sprites(path) {
    var status = false

    if !file_exists(path + ".nomedia") {
        var f = file_text_open_write(path + ".nomedia")
        file_text_write_string(f, "")
        file_text_close(f)
    }

    var _find = files_find_all(path + "*.png")

    var index = 0,
        b = 0

    var replace_frames = {}

    for(var _f = 0; _f < array_length(_find); _f ++) {
        var handled = 0,
			find = _find[_f]

        if string_char_at(find, 1) != "s" {
            handled = true
        }

        if !handled {
            var asset = -1

            asset = asset_get_index(string_replace(find, ".png", ""))

            if !sprite_exists(asset) {
                var p = string_pos("_strip", find)

                if p > 0 {
                    asset = asset_get_index(string_delete(find, p, string_length(find)))
                }
				else if string_count("_frame", find) {
                    var p = string_pos("_frame", find)

                    if p > 0 {
                        asset = asset_get_index(string_delete(find, p, string_length(find)))

                        if sprite_exists(asset) {
                            try {
                                var frame = string_digits(string_copy(find, p, string_length(find)))

                                var s = sprite_add(path + find, 1, 0, 0, 0, 0)

                                if sprite_exists(s) {
                                    var a = string(asset)
									
                                    if replace_frames[$ a] == undefined {
                                        replace_frames[$ a] = []
                                    }
									
                                    replace_frames[$ a][real(frame)] = s
									
									b = true
                                    handled = true
                                }
								else if !b {
                                    printc("[!!!] Failed to load frame " + find + " to replace", c_red)
                                    status = true
                                }
								else handled = true
                            }
							catch (e) {
                                printc("[!!!] Failed to parse framecount of sprite " + sprite_get_name(find), c_red)
                                status = true
                            }
                        }
						else {
                            print("[!] Couldn't find sprite for " + find + " to replace frames.", c_yellow)
                            status = true
                        }
                    }

                    handled = true
                }
            }
			
            if !handled && sprite_exists(asset) {
                var frames = sprite_get_number(asset)
                var sprite = sprite_add(path + find, frames, 0, 0, sprite_get_xoffset(asset), sprite_get_yoffset(asset))

                if sprite_exists(sprite) {
                    if sprite_get_width(sprite) == sprite_get_width(asset) && sprite_get_height(sprite) == sprite_get_height(asset) {
                        sprite_flush(sprite)
                        sprite_delete(sprite)

                        sprite_strip_save(asset, "replacedsprites/" + string(asset) + ".png")
                        array_push(global.customSprites, asset)

                        if sprite_replace(asset, path + find, sprite_get_number(asset), 0, 0, sprite_get_xoffset(asset), sprite_get_yoffset(asset)) {
                            // ok
                        } else {
                            printc("[!!!] Failed to replace sprite " + find, c_red);
                            status = true
                        }
                    } else {
                        print("[!!!]", find, "image is invalid. Requested dimensions:",
                        sprite_get_width(asset), "x", string(sprite_get_height(asset)) + ",", "got",
                        sprite_get_width(sprite), "x", sprite_get_height(sprite))

                        printc("^^^ " + find + " is not being replaced", c_red)

                        status = true
                        sprite_flush(sprite)
                        sprite_delete(sprite)
                    }
                }
				else {
                    printc("[!!!] Unable to create sprite for " + find, c_red);
                    status = true
                }
            }
			else if !b {
                printc("[!] Unable to find sprite named " + find, c_yellow);
                status = true
            }
        }
    }
	
    var keys = struct_keys(replace_frames)
	
    for (var j = 0; j < array_length(keys); j++) {
        var f = replace_frames[$ keys[j]]
        var asset = real(keys[j])
		
        sprite_replace_frames(asset, f)
    }
	
    return status
}