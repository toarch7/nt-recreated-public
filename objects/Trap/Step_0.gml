if fire > 0 && !instance_exists(Portal) {
    if side {
        if !position_meeting(x - 16 + 8, y, Wall) {
            with instance_create(x - 4, y + 8, TrapFire) {
                hit_id = sprKilledByTrap
                hspeed = -6
            }
        }

        if !position_meeting(x + 16 + 8, y, Wall) {
            with instance_create(x + 20, y + 8, TrapFire) {
                hit_id = sprKilledByTrap
                hspeed = 6
            }
        }
    } else {
        if !position_meeting(x + 8, y - 16, Wall) {
            with instance_create(x + 8, y - 4, TrapFire) {
                hit_id = sprKilledByTrap
                vspeed = -6
            }
        }

        if !position_meeting(x + 8, y + 16, Wall) {
            with instance_create(x + 8, y + 20, TrapFire) {
                hit_id = sprKilledByTrap
                vspeed = 6
            }
        }
    }

    fire--
}

if !position_meeting(x, y, Wall) {
    instance_destroy()
}