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

