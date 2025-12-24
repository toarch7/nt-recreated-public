repeat (3) {
	scrWeaponPickupCreate(x, y, scrDecideWepGold(), true)
}

event_inherited()

with (MusCont) alarm[1] = 1