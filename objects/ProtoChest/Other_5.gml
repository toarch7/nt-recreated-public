if UberCont.daily_run exit

if wep == 120 {
    wep = 255
}

if !instance_exists(CoopController) {
	if sprite_index == sprProtoChestOpen {
	    UberCont.protowep = 56
	} else {
	    UberCont.protowep = wep
	    save_set_value("etc", "protowep", wep)
	}
} else {
	if sprite_index == sprProtoChestOpen {
	    CoopController.protowep = 56
	} else {
	    CoopController.protowep = wep
	}
}