if (instance_exists(crystaltype) && (instance_exists(target) && ((intro == 1) && (hp != max_hp)))) {
    jmp = instance_nearest(target.x, target.y, crystaltype)
    wantdist = 60
    if (point_distance(jmp.x, jmp.y, target.x, target.y) < 140) {
        snd_play_hit_big(sndHyperCrystalSearch, 0.2)
        with(jmp) {
            alarm[4] = 40
            explode = 1
        }
    }
} else alarm[1] = 5