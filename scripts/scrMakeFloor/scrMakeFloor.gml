function scrMakeFloor() {
    x += lengthdir_x(32, direction)
    y += lengthdir_y(32, direction)

    if GameCont.area == 1 {
        if (rng_rnd(0, 0, 2) < 1) {
            instance_create(x, y, Floor)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
        } else instance_create(x, y, Floor)
    }

    if GameCont.area == 0 || GameCont.area == 2 || GameCont.area == 102 || GameCont.area == 6 || GameCont.area == 101 || GameCont.area == 105 {
        instance_create(x, y, Floor)
    }

    if GameCont.area == 3 {
        if ((rng_rnd(0, 0, 8) < 1) || (GameCont.subarea == 3)) {
            if (GameCont.subarea == 3) {
                xoff = rng_choose(0, 32, 0, 0, - 32)
                yoff = rng_choose(0, 32, 0, 0, - 32)
            } else {
                xoff = 0
                yoff = 0
            }
            instance_create((x + xoff), (y + yoff), Floor)
            instance_create(((x + xoff) + 32), (y + yoff), Floor)
            instance_create(((x + xoff) + 32), ((y + yoff) + 32), Floor)
            instance_create((x + xoff), ((y + yoff) + 32), Floor)
            instance_create((x + xoff), ((y + yoff) - 32), Floor)
            instance_create(((x + xoff) - 32), (y + yoff), Floor)
            instance_create(((x + xoff) + 32), ((y + yoff) - 32), Floor)
            instance_create(((x + xoff) - 32), ((y + yoff) - 32), Floor)
            instance_create(((x + xoff) - 32), ((y + yoff) + 32), Floor)
        } else instance_create(x, y, Floor)
    }
    if GameCont.area == 4 instance_create(x, y, Floor) if GameCont.area == 5 {
        if (rng_rnd(0, 0, 11) < 1) {
            if (rng_rnd(0, 0, 2) < 1) {
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x - 32, y, Floor)
                instance_create(x + 32, y - 32, Floor)
                instance_create(x - 32, y - 32, Floor)
                instance_create(x - 32, y + 32, Floor)
            } else {
                instance_create(x + 64, y - 64, Floor)
                instance_create(x + 64, y - 32, Floor)
                instance_create(x + 64, y, Floor)
                instance_create(x + 64, y + 32, Floor)
                instance_create(x + 64, y + 64, Floor)
                instance_create(x - 64, y - 64, Floor)
                instance_create(x - 64, y - 32, Floor)
                instance_create(x - 64, y, Floor)
                instance_create(x - 64, y + 32, Floor)
                instance_create(x - 64, y + 64, Floor)
                instance_create(x, y - 64, Floor)
                instance_create(x - 32, y - 64, Floor)
                instance_create(x + 32, y - 64, Floor)
                instance_create(x, y + 64, Floor)
                instance_create(x - 32, y + 64, Floor)
                instance_create(x + 32, y + 64, Floor)
            }
        } else instance_create(x, y, Floor)
    }

    if GameCont.area == 7 {
        if (rng_rnd(0, 0, 16) < 1) {
            dix = -32
            diy = -32
            repeat(4) {
                repeat(4) {
                    instance_create((x + dix), (y + diy), Floor)
                    dix += 32
                }
                dix = -32
                diy += 32
            }
        } else {
            instance_create(x, y, Floor)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
        }
    }
    if GameCont.area == 100 {
        if (rng_rnd(0, 0, 8) < 1) {
            dir = rng_choose(0, 0, 2)
            if (dir == 1) {
                instance_create(x + 32, y, Floor)
                instance_create(x + 64, y, Floor)
                instance_create(x, y, Floor)
                instance_create(x - 32, y, Floor)
                instance_create(x - 64, y, Floor)
            } else {
                instance_create(x, y + 32, Floor)
                instance_create(x, y + 64, Floor)
                instance_create(x, y, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x, y - 64, Floor)
            }
        } else instance_create(x, y, Floor)
    }
    if (GameCont.area == 103 || GameCont.area == 107) {
        if ((round((instance_number(Floor) / 12)) == (instance_number(Floor) / 12)) && (instance_number(Floor) != 0)) {
            x += lengthdir_x(32, direction)
            y += lengthdir_y(32, direction)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
            instance_create(x, y - 32, Floor)
            instance_create(x - 32, y, Floor)
            instance_create(x + 32, y - 32, Floor)
            instance_create(x - 32, y - 32, Floor)
            instance_create(x - 32, y + 32, Floor)
        } else instance_create(x, y, Floor)
    }
    if GameCont.area == 106 {
        if ((round((instance_number(Floor) / 8)) == (instance_number(Floor) / 8)) && (instance_number(Floor) != 0)) {
            x += lengthdir_x(64, direction)
            y += lengthdir_y(64, direction)
            instance_create(x - 64, y - 64, Floor)
            instance_create(x - 64, y - 32, Floor)
            instance_create(x - 64, y, Floor)
            instance_create(x - 64, y + 32, Floor)
            instance_create(x - 64, y + 64, Floor)
            instance_create(x + 64, y - 64, Floor)
            instance_create(x + 64, y - 32, Floor)
            instance_create(x + 64, y, Floor)
            instance_create(x + 64, y + 32, Floor)
            instance_create(x + 64, y + 64, Floor)
            instance_create(x - 32, y + 64, Floor)
            instance_create(x, y + 64, Floor)
            instance_create(x + 32, y + 64, Floor)
            instance_create(x - 32, y - 64, Floor)
            instance_create(x, y - 64, Floor)
            instance_create(x + 32, y - 64, Floor)
            x += lengthdir_x(64, direction)
            y += lengthdir_y(64, direction)
        } else if (rng_rnd(0, 0, 3) < 1) {
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
            instance_create(x, y - 32, Floor)
            instance_create(x - 32, y, Floor)
            instance_create(x + 32, y - 32, Floor)
            instance_create(x - 32, y - 32, Floor)
            instance_create(x - 32, y + 32, Floor)
        } else {
            repeat(4) {
                instance_create(x, y, Floor)
                x += lengthdir_x(32, direction)
                y += lengthdir_y(32, direction)
                instance_create(x, y, Floor)
                instance_create(x + 16, y + 16, AmmoChest)
            }
            if (rng_rnd(0, 0, 3) < 1) {
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x - 32, y, Floor)
                instance_create(x + 32, y - 32, Floor)
                instance_create(x - 32, y - 32, Floor)
                instance_create(x - 32, y + 32, Floor)
            }
        }
    }
    if (GameCont.area == 101 && (rng_rnd(0, 0, 3) < 1)) {
        instance_create(x - 32, y, Floor)
        instance_create(x + 32, y, Floor)
        instance_create(x, y - 32, Floor)
        instance_create(x, y + 32, Floor)
    }
    if GameCont.area == 104 {
        if (instance_number(Floor) < 4) {
            instance_create(x - 32, y, Floor)
            instance_create(x - 32, y - 32, Floor)
            instance_create(x - 32, y + 32, Floor)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y - 32, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
            instance_create(x, y - 32, Floor)
        }

        x += rng_choose(0, 64, - 64)
        y += rng_choose(0, 64, - 64)

        instance_create(x - 32, y, Floor)
        instance_create(x - 32, y - 32, Floor)
        instance_create(x - 32, y + 32, Floor)
        instance_create(x + 32, y, Floor)
        instance_create(x + 32, y - 32, Floor)
        instance_create(x + 32, y + 32, Floor)
        instance_create(x, y + 32, Floor)
        instance_create(x, y - 32, Floor)
    }

    if GameCont.area == 105 {
        if (rng_rnd(0, 0, 4) < 1) {
            instance_create(x, y, Floor)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
        } else instance_create(x, y, Floor)
    }

    trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, - 90, 90, - 90, 180)

    if GameCont.area == 0 trn = rng_choose(0, 0, 90, - 90, 90, - 90, 180) if GameCont.area == 2 || GameCont.area == 102 trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, - 90, 90, - 90, 180) if GameCont.area == 3 trn = rng_choose(0, 0, 0, 0, 0, 90, - 90) if GameCont.area == 4 trn = rng_choose(0, 0, 0, 0, 0, 90, - 90, 180) if GameCont.area == 5 trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 180, 180, rng_choose(0, 90, - 90)) if GameCont.area == 6 trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, - 90, 180) if GameCont.area == 7 trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, - 90, 180) if GameCont.area == 100 trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, - 90, 180, 180) if GameCont.area == 101 trn = rng_choose(0, 0, 0, 0, 90, - 90, 90, - 90, 180) if GameCont.area == 103 trn = rng_choose(0, 0, 0, 0, 90, - 90, 180) if GameCont.area == 105 trn = rng_choose(0, 0, 0, 0, 0, 0, 90, - 90, 90, - 90, 180) if GameCont.area == 106 trn = rng_choose(0, 0, 90, - 90, 90, - 90, 180) direction += trn

    if abs(trn) == 90 && GameCont.area == 6 && rng_rnd(0, 0, 2) < 1 {
        instance_create(x + 32, y, Floor)
        instance_create(x + 32, y + 32, Floor)
        instance_create(x, y + 32, Floor)
        instance_create(x, y - 32, Floor)
        instance_create(x - 32, y, Floor)
        instance_create(x + 32, y - 32, Floor)
        instance_create(x - 32, y - 32, Floor)
        instance_create(x - 32, y + 32, Floor)

        if (rng_rnd(0, 0, 3) < 1) {
            if (rng_rnd(0, 0, 4) < 3) instance_create(x - 16, y - 16, Server)
            if (rng_rnd(0, 0, 4) < 3) instance_create((x - 16 + 64), y - 16, Server)
            if (rng_rnd(0, 0, 4) < 3) instance_create(x - 16, (y - 16 + 64), Server)
            if (rng_rnd(0, 0, 4) < 3) instance_create((x - 16 + 64), (y - 16 + 64), Server)
        }
    }

    if (((trn == 180) || ((abs(trn) == 90) && (GameCont.area == 3 || GameCont.area == 104))) && (point_distance(x, y, 10016, 10016) > 48)) {
        instance_create(x, y, Floor)
        if (GameCont.area != 107) instance_create(x + 16, y + 16, WeaponChest)
    }
    if GameCont.area == 0 {
        if (rng_rnd(0, 0, (19 + instance_number(FloorMaker))) > 22) {
            instance_destroy()
            if (point_distance(x, y, 10016, 10016) > 48) {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }
        }
        if (rng_rnd(0, 0, 4) < 1) instance_create(x, y, FloorMaker)
    }
    if GameCont.area == 106 {
        if (rng_rnd(0, 0, 10) < 1) {
            if (point_distance(x, y, 10016, 10016) > 48) {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }
        }
        if (instance_number(Floor) > (instance_number(FloorMaker) * 28)) instance_create(x, y, FloorMaker)
    }
    if (GameCont.area == 1 || GameCont.area == 101) {
        if (rng_rnd(0, 0, (19 + instance_number(FloorMaker))) > 20) {
            instance_destroy()
            if (point_distance(x, y, 10016, 10016) > 48) {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }
        }
        if (rng_rnd(0, 0, 8) < 1) instance_create(x, y, FloorMaker)
    }

    if GameCont.area == 2 {
        if rng_rnd(0, 0, 14 + instance_number(FloorMaker)) > 15 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 15) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 3 {
        if rng_rnd(0, 0, 39 + instance_number(FloorMaker)) > 40 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 25) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 4 || (GameCont.area == 104 && rng_rnd(0, 0, 4) < 1) {
        if rng_rnd(0, 0, 9 + instance_number(FloorMaker)) > 10 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 4) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 5 {
        if rng_rnd(0, 0, 14 + instance_number(FloorMaker)) > 15 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x, y, Floor)
                instance_create(x + 16, y + 16, AmmoChest)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 15) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 6 {
        if rng_rnd(0, 0, 21 + instance_number(FloorMaker)) > 22 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x, y, Floor)
                instance_create(x + 16, y + 16, AmmoChest)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 20) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 7 {
        if rng_rnd(0, 0, 8 + instance_number(FloorMaker)) > 9 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 16) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 102 || GameCont.area == 7 {
        if rng_rnd(0, 0, 9 + instance_number(FloorMaker)) > 10 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 5) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 103 || GameCont.area == 107 {
        if rng_rnd(0, 0, 31 + instance_number(FloorMaker)) > 32 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x, y, Floor)
                instance_create(x + 16, y + 16, AmmoChest)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 20) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }

    if GameCont.area == 105 || GameCont.area == 101 {
        if rng_rnd(0, 0, 19 + instance_number(FloorMaker)) > 20 {
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }

            instance_destroy()
        }

        if rng_rnd(0, 0, 14) < 1 {
            instance_create(x, y, FloorMaker)
        }
    }
}