alarm[0] = 5

if instance_exists(enemy) or instance_exists(NothingInactive) {
    target = noone

    with enemy {
		with instance_create(x, y, BECOMETARGET)
			creator = other.id
    }

    with NothingInactive {
	    if active {
			with instance_create(x, y, BECOMETARGET)
				creator = other.id
	    }
	}

    with BECOMETARGET {
        if collision_line(x, y, other.x, other.y, Wall, 1, 0) > 0 {
            instance_destroy()
        }
    }

    if instance_exists(BECOMETARGET) {
        target = instance_nearest(x, y, BECOMETARGET).creator
    }

    with BECOMETARGET
		instance_destroy()

    if target {
        gunangle = target_direction

        ammo--

        snd_play(sndEnemyFire)
        snd_play(sndPistol)

        wkick = 4

        with instance_create(x, y, Shell) {
            motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))
        }

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + random(12) - 6, 16)
            image_angle = direction
            team = other.team
        }

        BackCont.shake += 2
        wkick = 2
    }
}

if ammo <= 0 instance_destroy()