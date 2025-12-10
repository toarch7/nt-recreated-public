scrDrop(60, 0)
event_inherited()

with Player {
	if is_me && race == Race.Rogue {
	    UberCont.ctot_uniq[race] ++
	}
}

if random(4) < 1 {
    repeat 3 {
        with instance_create(x, y, PopoNade) {
            hit_id = other.hit_id
            motion_add(other.direction, 4)
            motion_add(random_angle, 4)
            image_angle = direction
            team = other.team
        }
    }
}

with WantVan
canspawn = 1

instance_create(x, y, WantRevivePopoFreak)