/// @description Save

if (wep == wep_frog_pistol) {
    wep = wep_golden_frog_pistol
}

if (!instance_exists(CoopController)) {
	if (sprite_index == sprProtoChestOpen) {
	    UberCont.protowep = wep_rusty_revolver
		UberCont.protocurse = false
	}
	else {
	    UberCont.protowep = wep
		UberCont.protocurse = curse
	}
}
else {
	if (sprite_index == sprProtoChestOpen) {
	    CoopController.protowep = wep_rusty_revolver
		CoopController.protocurse = false
	}
	else {
	    CoopController.protowep = wep
		CoopController.protocurse = curse
	}
}