event_inherited()

if roll = 0 {
    if walk > 0 {
        walk -= 1
        motion_add(direction, 0.8)
    }

    if speed > 3 speed = 3

    if instance_exists(target) {
        if target.speed > 0 or hp < max_hp {
			freeze += 1
		}
		
        if !target.can_shoot {
			freeze += 3
		}
	}
} else {
    //rolling
    speed = 5
    angle += 40 * right
    instance_create(x + random(6) - 3, y + random(6), Dust)

    if angle > 720 or - angle > 720 {
        angle = 0
        roll = 0
    }
}