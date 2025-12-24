scrLetterbox(true)

text = loc("YOU DID NOT REACH THE NUCLEAR THRONE")

if GameCont.area == area_palace && GameCont.subarea == 3 {
	text = loc("YOU ALMOST REACHED THE NUCLEAR THRONE")
}
else if GameCont.loops > 0 {
	text = loc("THE STRUGGLE CONTINUES")
}

if GameCont.win {
    if instance_exists(Cinematic) {
        text = loc("YOU HAVE REACHED THE NUCLEAR THRONE")
    }
	else if GameCont.area == 106 && GameCont.subarea == 3 {
        text = loc("THE STRUGGLE IS OVER")
    }
}

var _image = 0

repeat 2 {
    with instance_create(view_xview_center, view_yview_center + 58 + _image * 32, PauseButton) {
        image_index = _image++
		appear = 3 + _image
    }
}

if scrGameIsEventRun() {
	with (instance_find(PauseButton, 1)) sprite_index = sprGameOverResult
	
	if !scrGameIsWeeklyRun() {
	    instance_destroy(instance_find(PauseButton, 0))
	}
	else {
		with (instance_find(PauseButton, 0)) image_index = 1
	}
}

gameovertime = 0
splatimg = 0
death_pos = 0
offsety = 128

image_speed = 0.4

instance_destroy(MobileUI)

if (instance_exists(Credits)) depth = -102

file_delete(savegame_file)