if instance_number(enemy) <= 0 {
    instance_destroy()
    exit
}

if GameCont.subarea == 3 {
    treshhold = 0.9
} else treshhold = 0.98

if !instance_exists(CanOasis) {
    if instance_exists(enemy) && instance_number(enemy) - instance_number(RadMaggot) > (enemies * treshhold) {
        if GameCont.subarea == 3 {
            alarm[0] = 120
        }

        if !losthope && !instance_exists(chestprop) && instance_exists(ChestOpen) && !instance_exists(RadChest) && !instance_exists(RadChestBig) && !instance_exists(RadMaggotChest) && !instance_exists(RogueChest) {
            instance_create(x, y, CanOasis)
            alarm[0] = 1
        }
    }
}

if !losthope && instance_number(enemy) <= (enemies * treshhold) {
    with BigSkull {
        if spr_idle == sprBigSkullOpen {
            spr_idle = sprBigSkull
            spr_hurt = sprBigSkullHurt
            sprite_index = spr_idle
        }
    }

    losthope = 1
}

if GameCont.subarea != 3 && !instance_exists(enemy) {
    instance_destroy()
}