if GameCont.area == 100 {
    with instance_furthest(10016, 10016, Floor)
    instance_create(x + 16, y + 16, CrownPickup)
} else if !instance_exists(ProtoStatue) && GameCont.subarea == 2 && ((GameCont.area == 1 && GameCont.loops) or GameCont.area == 3 or GameCont.area == 5 or (GameCont.area == 7 && GameCont.loops)) && GameCont.crownvisits < 3 {
    flor = instance_furthest(10016, 10016, Floor)

    with instance_nearest(
    (flor.x * 2 + 10016) / 3 + random(128) - 64, (flor.y * 2 + 10016) / 3 + random(128) - 64,
    Floor) {
        instance_create(x + 16, y + 16, ProtoStatue)
    }
}

if GameCont.area == 107 {
    lowx = x
    lowy = -10000

    with Floor {
        if y > other.lowy {
            other.lowx = x
            other.lowy = y
        }
    }

    dix = -160
    diy = 0

    repeat 11 {
        repeat 7 {
            instance_create(lowx + dix, lowy + 32 + diy, Floor)
            diy += 32
        }

        dix += 32
        diy = 0
    }

    instance_create(lowx + 16, lowy + 248, VenuzTV)
    instance_create(lowx + 16, lowy + 104, VenuzCouch)
    instance_create(lowx + 16 - 64, lowy + 104, MoneyPile)
    instance_create(lowx + 16 + 64, lowy + 104, MoneyPile)
    if instance_exists(Player) {
        if GameCont.crown == 9 {
            instance_create(((lowx + 16) - 90), (lowy + 64), GiantAmmoChest)
            instance_create(((lowx + 16) + 90), (lowy + 64), GiantAmmoChest)
            //if (GameCont.skill_got[28] == 1)
            //    instance_create((lowx + 16), (lowy + 64), GiantAmmoChest)
        } else {
            instance_create(lowx + 16 - 90, lowy + 64, GiantWeaponChest)
            instance_create(lowx + 16 + 90, lowy + 64, GiantWeaponChest)
            if skill_get(28) {
                instance_create((lowx + 16), (lowy + 64), GiantWeaponChest)
            }
        }
    }

    instance_create(lowx + 16, lowy + 104, VenuzCarpet)

    lowx = x
    lowy = 100000000

    with Floor {
        if y < other.lowy {
            other.lowx = x
            other.lowy = y
        }
    }

    dix = -160
    diy = 0

    repeat 10 {
        repeat 7 {
            instance_create(lowx + dix, lowy + 32 + diy, Floor)

            if point_distance(10016, 10016, lowx + dix + 16, lowy + 32 + diy + 16) > 96 && (random(5) < 1 || instance_number(CarVenusFixed) == 0) {
                instance_create(((lowx + dix) + 16), (((lowy + 32) + diy) + 16), CarVenusFixed)
            }

            diy -= 32
        }

        dix += 32
        diy = 0
    }
}

with Smoke instance_destroy()
with SpiralCont alarm[0] = 1