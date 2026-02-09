target = noone
with (GameCont) {
	if (area == area_oasis || (area == area_palace && subarea == maxsubarea) || area == area_campfire || area == area_crib) {
		instance_destroy(other)
		break
	}
}
enemies = instance_number(enemy)
spawnmoment = (0.2 + random(0.4))
canspawn = 0