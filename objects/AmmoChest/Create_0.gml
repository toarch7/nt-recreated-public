if GameCont.area == 0 {
    instance_destroy(id, 0);
    exit
}

event_inherited()

if !(GameCont.area == 7 && GameCont.subarea == 3) && object_index == AmmoChest {
    if rng_random(4, 4) < 1 {
        instance_change(AmmoChestMystery, true)
    } else if rng_random(4, 40) < 1 && (GameCont.area >= 5 or GameCont.loops) {
        instance_change(IDPDChest, true)
    }
} else speed = 0