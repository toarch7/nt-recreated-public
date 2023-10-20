alarm[1] = 50
scrTarget()
if ((target >= Player) && instance_exists(target)) {
    if ((intro == 0) && (collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0)) {
        intro = 1
        alarm[3] = 2
        snd_play(sndHyperCrystalAppear)
        with(MusCont)
        alarm[2] = 1
    }
    if (crystals == 0) {
        snd_play_hit_big(sndHyperCrystalSpawn, 0.2)
        fastspin = 50
        dist = 0
        wantdist = 25
        dir = 0
        repeat cnumber {
            type = LaserCrystal
            if (GameCont.area == 104) {
                type = choose(InvLaserCrystal, InvLaserCrystal, InvLaserCrystal, LightningCrystal)
            }
            crystal[dir] = instance_create(x, y, type)
            GameCont.kills -= 1
            dir += 1
        }
        crystals = 1
    } else {
        dir = 0
        crs = 0
        repeat cnumber {
            if instance_exists(crystal[dir]) crs += 1
            dir += 1
        }
        if (crs <= (cnumber / 2)) {
            crystals = 0
            snd_play_hit_big(sndHyperCrystalRelease, 0.2)
        } else {
            wantdist = 80
            if ((target >= Player) && instance_exists(target)) {
                if ((collision_line(x, y, target.x, target.y, Wall, 0, 0) > 0) && (intro == 1)) {
                    snd_play_hit(sndHyperCrystalChargeExplo, 0.1)
                    wantdist = 120
                    nospin = 50
                    alarm[2] = 50
                    alarm[1] = 80
                }
            }
        }
    }
} else if (random(10) < 1) {
    motion_add(random_angle, 0.4)
    alarm[1] = (10 + random(30))
}