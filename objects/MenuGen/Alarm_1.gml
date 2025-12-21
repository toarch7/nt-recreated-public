with (Floor) {
    if (!position_meeting(x - 32, y, Floor)) instance_create(x - 32, y, Floor)
    if (!position_meeting(x + 32, y, Floor)) instance_create(x + 32, y, Floor)
    if (!position_meeting(x, y - 32, Floor)) instance_create(x, y - 32, Floor)
    if (!position_meeting(x, y + 32, Floor)) instance_create(x, y + 32, Floor)
}

with (Floor) mcr_floor_make_walls;

with (Floor) mcr_floor_create_tops;

instance_destroy(Smoke)
instance_destroy(RadChest, false)
instance_destroy(chestprop, false)
instance_destroy(ChestOpen, false)

with (Floor) {
    if (random(6) < 1) {
		if (irandom(21)) {
			if (distance_to_object(CampChar) > 24 && distance_to_object(NightCactus) > 16) {
				instance_create(x + 16, y + 16, NightCactus)
			}
        }
		else {
			instance_create(x + 16, y + 16, TopDecalNightDesert)
		}
	}
}

with (CampChar) instance_create(x, y, PortalClear)

call_after(1, function() {
	with (Wall) mcr_wall_update_lrwh;
})

scrMoveTopPots()