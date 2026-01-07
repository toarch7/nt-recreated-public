if instance_exists(UberCont) {
    with UberCont
		scrSetViewSize()
	
    instance_destroy()
    room_goto(romGame)
	
    exit
}

var check = false

if os_type == os_android {
    check = android_check_storage_permission()
	
    //if check == os_permission_denied or request_perm {
	if request_perm {
		var str = "The game needs access to read and write files for customization and saving progress." +
				  "\nIt is not strictly necessary if you're just a regular player - you can deny or revoke this permission" +
				  "in the System Preferences in case if you experience problems with your game data.",
			
			key = "Intro:FilesystemAccess";
		
		if (legacy) {
			str = "Previous game installation detected. Due to internal API version changes, the game now" +
				  "requires you to provide file a system access permission in order to import your current game progress." +
				  "\n\nYou can do this now and revoke the permission shortly after the game is loaded," +
				  "in case if you don't need to edit your save file."
			
			key = "Intro:FilesystemAccessV3Update"
		}
		
		message = show_message_async(loc(key, str))
		
        request_perm = false
        alarm[0] = -1

        exit
    }
}

if (alarm[0] > 0) exit

if os_type == os_android && check {
    game_directory = "/sdcard/games/com.toncho.nuclearthrone/files/"

    if !directory_exists(game_directory) {
        directory_create(game_directory)
    }
}
else {
	game_directory = string_replace_all(game_save_id, "//", "/")
}

my_player = undefined

with (instance_create(0, 0, UberCont)) {
	scrInitPostGamestart()
}

//
var info = os_get_info(), udid;
if (!ds_map_empty(info)) {
	udid = scrGenerateUID(info[? "udid"])
	save_set_value("general", "uid", udid)
}
ds_map_destroy(info)

//
randomize()

if (!loading) {
	if (save_get_value("etc", "disclaimer", false)) {
		if (!disclaimer) room_goto(romGame)
	}
	else {
		disclaimer = true
	}
	exit
}

scrVolume()

try {
	instance_create(0, 0, GameCont)
	
	scrSavegameLoad()
	
	instance_create(0, 0, SpiralCont)
	instance_create(0, 0, TopCont)
	
	scrLetterbox(true)
    
	depth = UberCont.depth - 1
}
catch(e) {
	/// @loc:token [R:Intro] LoadGameFailure "Failed to load saved run."
    print_exception(loc("R:Intro:LoadGameFailure", "Failed to load saved run."), e)
	event_user(0)
}