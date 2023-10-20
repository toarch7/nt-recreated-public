with Floor {
    if random(6) < 1 {
		if irandom(21) {
			if distance_to_object(CampChar) > 24 && distance_to_object(NightCactus) > 16
				instance_create(x + 16, y + 16, NightCactus)
        }
		else instance_create(x + 16, y + 16, TopDecalNightDesert)
    }
}

with CampChar {
    instance_create(x, y, PortalClear)
}

scrMoveTopPots()