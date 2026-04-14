event_inherited()

wep = UberCont.protowep
curse = UberCont.protocurse

if instance_exists(CoopController) {
	wep = CoopController.protowep
	curse = CoopController.protocurse
}

// prevents the protochest from teleporting via being
// pushed onto crown pedestal via telekinesis. only
// allow pushing for 3 seconds after level start
crownpedtime = current_frame + 90