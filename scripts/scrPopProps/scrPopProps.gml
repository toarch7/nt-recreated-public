function scrPopProps() {
    var roll = rng_next_float(2)
    random_set_seed(global.rng_state[2])

    if !place_meeting(x, y, hitme) && !place_meeting(x, y, chestprop) {
        if random(5) < 1 && point_distance(10016, 10016, x, y) > 100 && !place_meeting(x, y, NOWALLSHEREPLEASE) && GameCont.area != 106 && ((GameCont.area != 101) || (random(3) < 1)) && GameCont.area != 100 && GameCont.area != 0 && GameCont.area != 107 && GameCont.area != 6 && !(GameCont.area == 3 && GameCont.subarea == 3) && !(GameCont.area == 7 && GameCont.subarea == 3) && (GameCont.area != 5 || random(3) < 1) && GameCont.area != 102 && !(GameCont.loops > 0 && GameCont.area == 0) {
            var myx = (x + choose(0, 16))
            var myy = (y + choose(0, 16))

            if !place_meeting(myx, myy, hitme) {
                instance_create(myx, myy, Wall)
                instance_create(x, y, NOWALLSHEREPLEASE)
                if random(4) < 1 && point_distance(myx, myy, 10016, 10016) > 64 && spawnarea == 3 && myx == x && myy == y && !place_meeting(myx, myy, chestprop) {
                    instance_create(myx, myy, Trap)
                }
            }
        } else if random(10) < 1 || (GameCont.area == 105 && random(2) < 1) || (GameCont.area == 0 && random(7) < 1) {
            if spawnarea == 1 {
                if random(60) < 1 {
                    instance_create(x + 16, y + 16, BigSkull)
                } else if styleb && random(5) < 1 {
                    instance_create(x + 16, y + 16, BonePile)
                } else {
                    instance_create(x + 16, y + 16, choose(Cactus, Cactus, TopDecalDesert, Cactus))
                }
            }

            if spawnarea == 106 {
                if !styleb && GameCont.subarea != 3 {
                    instance_create(x + 16, y + 16, PlantPot)
                }

                if GameCont.subarea != 3 || random(6) < 1 {
                    repeat 3 {
                        instance_create(x + 16, y + 16, TopPot)
                    }
                }
            }

            if spawnarea == 2 && point_distance(x + 16, y + 16, 10016, 10016) > 96 {
                instance_create(x + 16, y + 16, choose(Pipe, Pipe, ToxicBarrel, Pipe, Pipe, ToxicBarrel, TopDecalSewers))
            }

            if spawnarea == 0 {
                instance_create(x + 16, y + 16, choose(NightCactus, NightCactus, NightBonePile, TopDecalNightDesert))
            }

            if (spawnarea == 4) {
                if styleb && random(5) < 1 {
                    instance_create(x + 16, y + 16, BonePile)
                } else {
                    instance_create(x + 16, y + 16, choose(Crystal, Crystal, TopDecalCave, Cocoon))
                }
            }

            if spawnarea == 104 {
                if styleb && random(5) < 1 {
                    instance_create(x + 16, y + 16, BonePile)
                } else {
                    instance_create(x + 16, y + 16, TopDecalCave)
                }
            }

            if spawnarea == 3 {
                instance_create(x + 16, y + 16, choose(Tires, Car, Tires, Car, Car, Tires, TopDecalScrapyard))
            }

            if spawnarea == 5 {
                if random(35) < 1 {
                    instance_create(x + 16, y + 16, choose(SnowMan, SodaMachine))
                } else if random(3) < 1 {
                    if random(2) < 1 {
                        with instance_nearest(x, y, Wall) {
                            instance_create(x + 8, y + 8, TopDecalCity)
                        }
                    } else instance_create(x + 16 + random_spread(4), y + 16 + random_spread(4), StreetLight)
                } else if distance_to_point(10016, 10016) > 128 instance_create(x + 16, y + 16, choose(Hydrant, Car))
            }

            if spawnarea == 6 && random(4) < 1 {
                instance_create(x + 16, y + 16, choose(Tube, Tube, Tube, Tube, MutantTube))
            }

            if spawnarea == 7 && GameCont.subarea != 3 {
                instance_create(x + 16, y + 16, choose(Pillar, SmallGenerator, TopDecalPalace))
            }

            if spawnarea == 100 {
                instance_create(x + 16, y + 16, Torch)
            }

            if spawnarea == 101 {
                if random(40) < 1 {
                    instance_create(x + 16, y + 16, Anchor)
                } else if point_distance(x + 16, y + 16, 10016, 10016) > 96 {
                    instance_create(x + 16, y + 16, choose(WaterPlant, WaterPlant, LightBeam, LightBeam, OasisBarrel, WaterMine, WaterMine))
                }
            }

            if spawnarea == 103 && point_distance(x + 16, y + 16, 10016, 10016) > 64 {
                instance_create(x + 16, y + 16, choose(MoneyPile, MoneyPile, MoneyPile, YVStatue, GoldBarrel, MoneyPile))
            }

            if spawnarea == 102 {
                instance_create(x + 16, y + 16, choose(PizzaBox, PizzaBox, TopDecalSewers))
            }

            if spawnarea == 105 {
                if random(30) < 1 {
                    instance_create(x + 16, y + 16, choose(BigFlower, BigFlower, TopDecalJungle))
                } else {
                    instance_create(x + 16, y + 16, Bush)
                }
            }
        }
    }
}