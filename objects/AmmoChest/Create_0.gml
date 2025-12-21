event_inherited()

spr_dead = sprAmmoChestOpen

if !(GameCont.area == area_palace && GameCont.subarea == GameCont.maxsubarea) {
	if !irandom(40) && (GameCont.area >= 4 || GameCont.loops > 0) {
		instance_create(x, y, IDPDChest)
		instance_destroy(id, false)
	}
	else if random(1) < 0.25 {
		instance_create(x, y, AmmoChestMystery)
		instance_destroy(id, false)
	}
}

if object_index == AmmoChest && scr_ultra_get(Race.Steroids, UltraSkill.GetLoaded) {
	sprite_index = sprAmmoChestSteroids
	spr_dead = sprAmmoChestSteroidsOpen
}