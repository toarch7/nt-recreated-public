globalvar game_directory;
game_directory = ""

scrLanguagesInit()
scrLanguagesLoad()

legacy = false
request_perm = false

if android_check_storage_permission() == os_permission_denied {
	if IsVersionR() && android_check_any_local_files() {
		request_perm = true
		legacy = true
	}
}

scr_debug_overlay_load()

alarm[0] = 1

disclaimer = false
disclaimer_setup = true
disclaimer_continue_pointed = false

/// @loc:note [R:Intro] The message is padded with newlines only as a stylistic choice, but automatic wordwrapping is supported.
/// @loc:token [R:Intro] ProjectDisclaimerText "@w###THIS IS AN UNOFFICIAL FAN-MADE RECREATION OF THE GAME.#THE DEVELOPER IS NOT AFFILIATED WITH THE ORIGINAL AUTHORS - @yVLAMBEER@w.##THIS IS A FREE AND OPEN-SOURCE GAME THAT IS DISTRIBUTED ON ITCH.IO#AND ITS SOURCE CODE IS FULLY AVAILABLE ON GITHUB.##IF YOU PAID TO GAIN ACCESS TO THIS GAME, OR WILL SEE ADS THOUGHOUT THE GAME, IT'S RECOMMENDED#THAT YOU UNINSTALL THE APPLICATION IMMEDIATELY."
disclaimer_message = "@w##THIS IS AN UNOFFICIAL FAN-MADE RECREATION OF THE GAME.#THE DEVELOPER IS NOT AFFILIATED WITH THE ORIGINAL AUTHORS - @yVLAMBEER@w.##THIS IS A FREE AND OPEN-SOURCE GAME THAT IS DISTRIBUTED ON ITCH.IO#"
		+ "AND ITS SOURCE CODE IS FULLY AVAILABLE ON GITHUB.##IF YOU PAID TO GAIN ACCESS TO THIS GAME, OR WILL SEE ADS THOUGHOUT THE GAME, IT'S RECOMMENDED#THAT YOU UNINSTALL THE APPLICATION IMMEDIATELY."

pos = 0
posy = 8

pointed_item = -1

loading = file_exists(savegame_file)

game_directory = "/files/"

message = -1

date_set_timezone(timezone_utc)

display_set_timing_method(tm_sleep)
display_set_sleep_margin(33)

texture_prefetch("bosses")
texture_prefetch("portraits")
texture_prefetch("rare")
texture_prefetch("ui")