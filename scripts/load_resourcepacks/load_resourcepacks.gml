function load_resourcepacks() {
    globalvar Resourcepacks;
    Resourcepacks = []

    global.customSounds = {}
    global.customSprites = []
    global.customareacolors = {}
    global.customshadowcolors = {}
	
	if !directory_exists(game_directory + "resourcepacks") {
		directory_create(game_directory + "resourcepacks")
	}
	
    load_resourcepacks_from(game_directory + "resourcepacks/")
}

function load_resourcepacks_from(p) {
    var status = 0

    print("Loading resourcepacks at " + p)

    var list = []
    var f = file_find_first(p + "*", fa_directory)

    while f != "" {
        array_push(list, f)
        f = file_find_next()
    }

    file_find_close()

    for (var i = 0; i < array_length(list); i++) {
        var l = 0,
            status = 0

            global.log_output = []
            global.log_color = []

        var f = list[i]

        print("Loading pack \"" + f + "\"")

        var r = p + f + "/"
        var data = {}

        if file_exists(r + "meta.json") {
            try {
                var data = json_parse(file_read(r + "meta.json"))

                if data[$ "name"] == undefined data[$ "name"] = f

                if data[$ "descriptionShort"] == undefined data[$ "descriptionShort"] = ""

                if data[$ "description"] == undefined data[$ "description"] = ""
            } catch (e) {
                printc("!!! Failed to parse meta.json: " + e.message, c_red)

                data[$ "name"] = f
                data[$ "descriptionShort"] = "[!!!] meta.json is malformed"
                data[$ "description"] = "Failed to parse JSON structure of meta.json. If you're creator of this resourcepack, you should verify integrity of the file syntax."
            }
        } else {
            printc("! Unable to find metadata file.", c_yellow)

            data[$ "name"] = f
            data[$ "descriptionShort"] = "[!] meta.json is missing"
            data[$ "description"] = "No extra info provided. If you're creator of this resourcepack, you might want to create meta.json file to give this pack extra info"
        }

        data[$ "id"] = f

        data[$ "icon"] = -1

        data[$ "path"] = r

        var active = !file_exists(r + "disable.d")

        data[$ "active"] = active

        if file_exists(r + "icon.png") {
            data[$ "icon"] = sprite_add(r + "icon.png", 1, 0, 0, 0, 0)
        }

        var info = {}

        if file_exists(r + "githubdata.json") {
            try {
                info = json_parse(file_read(r + "githubdata.json"))
            } catch (e) {
                printc("[!] githubdata.json is present, but parse failed: " + e.message, c_yellow)
            }
        } else l = 1

        if active {
            if directory_exists(r + "usersprites") status += load_custom_sprites(r + "usersprites/")

            if directory_exists(r + "usersounds") status += load_custom_sounds(r + "usersounds/")

            if directory_exists(r + "localizations") status += load_custom_locales(r + "localizations/")

            if file_exists(r + "areacolors.json") status += load_custom_area_colors(r + "areacolors.json")

            if file_exists(r + "shadowcolors.json") status += load_custom_shadow_colors(r + "shadowcolors.json")
        }

        data[$ "info"] = info

        array_push(Resourcepacks, data)
		
        if l && status > 0 {
            var str = "Something went wrong:\n\n"

            for (var j = 0; j < array_length(global.log_output); j++) {
                str += global.log_output[j] + "\n"
            }

            if !global.pc_build show_message_async(str)
            else {
                if !instance_exists(Console) instance_create(0, 0, Console)

                global.console_active = 1
            }
        }
    }
}