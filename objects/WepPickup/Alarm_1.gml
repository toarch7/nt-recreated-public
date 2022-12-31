if speed > 0 {
    alarm[1] = 30
    exit
}

if !instance_exists(creator) or!visible exit

with creator {
    if !bwep {
        if !wep {
            wep = other.wep
            reload = 0
        } else {
            bwep = other.wep
            breload = 0
        }

        repeat 4 {
            instance_create(other.x + random(12) - 6, other.y + random(12) - 6, Dust)
        }

        repeat 2 {
            scrSwapWeps()
        }

        instance_destroy(other.id, 1)
    }
}