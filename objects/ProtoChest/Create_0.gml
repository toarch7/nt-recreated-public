event_inherited()

wep = UberCont.protowep
curse = UberCont.protocurse

if instance_exists(CoopController) {
	wep = CoopController.protowep
	curse = CoopController.protocurse
}