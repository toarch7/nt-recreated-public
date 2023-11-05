if GameCont.area == 0 { instance_destroy(id, 0); exit }

event_inherited()

if !(GameCont.area == 7 && GameCont.subarea == 3) {
	if !irandom(40) && (GameCont.area >= 4 or GameCont.loops) {
		instance_change(IDPDChest, false)
	}
	else if !irandom(4)
		instance_change(AmmoChestMystery, false)
}