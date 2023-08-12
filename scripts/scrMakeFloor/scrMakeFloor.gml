function scrMakeFloor() {
    x += ldrx(32, direction)
    y += ldry(32, direction)

    var _area = GameCont.area,
        _mod = is_string(_area),
        xoff, yoff,
        dix, diy,
        trn, dir
	
    // create actual floors:
    switch _area {
        case 1:
            if rng_random(0, 2) < 1 {
                instance_create(x, y, Floor)
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
            }
			else instance_create(x, y, Floor)
			
            break
        case 3:
            if rng_random(0, 8) < 1 or GameCont.subarea == 3 {
                if GameCont.subarea == 3 {
                    xoff = rng_choose(0, 32, 0, 0, -32)
                    yoff = rng_choose(0, 32, 0, 0, -32)
                }
				else {
                    xoff = 0
                    yoff = 0
                }
				
                instance_create(x + xoff, y + yoff, Floor)
                instance_create(x + xoff + 32, y + yoff, Floor)
                instance_create(x + xoff + 32, y + yoff + 32, Floor)
                instance_create(x + xoff, y + yoff + 32, Floor)
                instance_create(x + xoff, y + yoff - 32, Floor)
                instance_create(x + xoff - 32, y + yoff, Floor)
                instance_create(x + xoff + 32, y + yoff - 32, Floor)
                instance_create(x + xoff - 32, y + yoff - 32, Floor)
                instance_create(x + xoff - 32, y + yoff + 32, Floor)
            }
			else instance_create(x, y, Floor)
			
            break
        case 5:
            if rng_random(0, 11) < 1 {
                if rng_random(0, 2) < 1 {
                    instance_create(x + 32, y, Floor)
                    instance_create(x + 32, y + 32, Floor)
                    instance_create(x, y + 32, Floor)
                    instance_create(x, y - 32, Floor)
                    instance_create(x - 32, y, Floor)
                    instance_create(x + 32, y - 32, Floor)
                    instance_create(x - 32, y - 32, Floor)
                    instance_create(x - 32, y + 32, Floor)
                }
				else {
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
            }
			else instance_create(x, y, Floor)
			
            break
        case 7:
            if rng_random(0, 16) < 1 {
                dix = -32
                diy = -32
				
                repeat 4 {
                    repeat 4 {
                        instance_create(x + dix, y + diy, Floor)
                        dix += 32
                    }
					
                    dix = -32
                    diy += 32
                }
            }
			else {
                instance_create(x, y, Floor)
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
            }
			
            break
		
        case 100:
            if rng_random(0, 8) < 1 {
                dir = rng_choose(0, 1, 2)
				
                if dir == 1 {
                    instance_create(x + 32, y, Floor)
                    instance_create(x + 64, y, Floor)
                    instance_create(x, y, Floor)
                    instance_create(x - 32, y, Floor)
                    instance_create(x - 64, y, Floor)
                }
				else {
                    instance_create(x, y + 32, Floor)
                    instance_create(x, y + 64, Floor)
                    instance_create(x, y, Floor)
                    instance_create(x, y - 32, Floor)
                    instance_create(x, y - 64, Floor)
                }
            }
			else instance_create(x, y, Floor)
			
            break
        case 103:
        case 107:
            if round(instance_number(Floor) / 12) == instance_number(Floor) / 12 && instance_number(Floor) != 0 {
                x += ldrx(32, direction)
                y += ldry(32, direction)
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x - 32, y, Floor)
                instance_create(x + 32, y - 32, Floor)
                instance_create(x - 32, y - 32, Floor)
                instance_create(x - 32, y + 32, Floor)
            }
			else instance_create(x, y, Floor)
			
            break
        case 106:
            if round(instance_number(Floor) / 8) == instance_number(Floor) / 8 && instance_number(Floor) != 0 {
                x += ldrx(64, direction)
                y += ldry(64, direction)
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
                x += ldrx(64, direction)
                y += ldry(64, direction)
            } else if rng_random(0, 3) < 1 {
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x - 32, y, Floor)
                instance_create(x + 32, y - 32, Floor)
                instance_create(x - 32, y - 32, Floor)
                instance_create(x - 32, y + 32, Floor)
            } else {
                repeat 4 {
                    instance_create(x, y, Floor)
                    x += ldrx(32, direction)
                    y += ldry(32, direction)
                    instance_create(x, y, Floor)
                    instance_create(x + 16, y + 16, AmmoChest)
                }
                if rng_random(0, 3) < 1 {
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
            break
        case 101:
            instance_create(x, y, Floor)
			
            if rng_random(0, 3) < 1 {
                instance_create(x - 32, y, Floor)
                instance_create(x + 32, y, Floor)
                instance_create(x, y - 32, Floor)
                instance_create(x, y + 32, Floor)
            }
			
            break
        case 104:
            if instance_number(Floor) < 4 {
                instance_create(x - 32, y, Floor)
                instance_create(x - 32, y - 32, Floor)
                instance_create(x - 32, y + 32, Floor)
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y - 32, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
                instance_create(x, y - 32, Floor)
            }
            x += rng_choose(0, 64, -64)
            y += rng_choose(0, 64, -64)
            instance_create(x - 32, y, Floor)
            instance_create(x - 32, y - 32, Floor)
            instance_create(x - 32, y + 32, Floor)
            instance_create(x + 32, y, Floor)
            instance_create(x + 32, y - 32, Floor)
            instance_create(x + 32, y + 32, Floor)
            instance_create(x, y + 32, Floor)
            instance_create(x, y - 32, Floor)
            break
        case 105:
            if rng_random(0, 4) < 1 {
                instance_create(x, y, Floor)
                instance_create(x + 32, y, Floor)
                instance_create(x + 32, y + 32, Floor)
                instance_create(x, y + 32, Floor)
            } else instance_create(x, y, Floor)
            break
        default:
            instance_create(x, y, Floor)
    } // switch (_area)

    // turn:
    switch _area {
        case 0:
            trn = rng_choose(0, 0, 90, -90, 90, -90, 180)
            break
        case 2:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 90, -90, 180)
            break
        case 102:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 90, -90, 180)
            break
        case 3:
            trn = rng_choose(0, 0, 0, 0, 0, 90, -90)
            break
        case 4:
            trn = rng_choose(0, 0, 0, 0, 0, 90, -90, 180)
            break
        case 5:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 180, 180, rng_choose(0, 90, -90))
            break
        case 6:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 180)
            break
        case 7:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 180)
            break
        case 100:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 180, 180)
            break
        case 101:
            trn = rng_choose(0, 0, 0, 0, 90, -90, 90, -90, 180)
            break
        case 103:
            trn = rng_choose(0, 0, 0, 0, 90, -90, 180)
            break
        case 105:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 90, -90, 90, -90, 180)
            break
        case 106:
            trn = rng_choose(0, 0, 90, -90, 90, -90, 180)
            break
        default:
            trn = rng_choose(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, -90, 90, -90, 180)
    }
    direction = (direction + trn) % 360
    //
    if abs(trn) == 90 && _area == 6 && rng_random(0, 2) < 1 {
        instance_create(x + 32, y, Floor)
        instance_create(x + 32, y + 32, Floor)
        instance_create(x, y + 32, Floor)
        instance_create(x, y - 32, Floor)
        instance_create(x - 32, y, Floor)
        instance_create(x + 32, y - 32, Floor)
        instance_create(x - 32, y - 32, Floor)
        instance_create(x - 32, y + 32, Floor)
        if rng_random(0, 3) < 1 {
            if rng_random(0, 4) < 3 instance_create(x - 16, y - 16, Server)
            if rng_random(0, 4) < 3 instance_create(x - 16 + 64, y - 16, Server)
            if rng_random(0, 4) < 3 instance_create(x - 16, y - 16 + 64, Server)
            if rng_random(0, 4) < 3 instance_create(x - 16 + 64, y - 16 + 64, Server)
        }
    }
    if (trn == 180 or abs(trn) == 90 && (_area == 3 or _area == 104)) && point_distance(x, y, 10016, 10016) > 48 {
        instance_create(x, y, Floor)
        if (_area != 107 && _area != 0) instance_create(x + 16, y + 16, WeaponChest)
    }
    //
    switch _area {
        case 0:
            if rng_random(0, 19 + instance_number(FloorMaker)) > 22 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    //instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
            }
            if rng_random(0, 4) < 1 instance_create(x, y, FloorMaker)
            break
        case 106:
            if rng_random(0, 10) < 1 {
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
            }
            if (instance_number(Floor) > instance_number(FloorMaker) * 28) instance_create(x, y, FloorMaker)
            break
        case 1:
        case 101:
            if rng_random(0, 19 + instance_number(FloorMaker)) > 20 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
            }
            if rng_random(0, 8) < 1 instance_create(x, y, FloorMaker)
            break
        case 2:
            if rng_random(0, 14 + instance_number(FloorMaker)) > 15 {
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
                instance_destroy()
            }
            if rng_random(0, 15) < 1 instance_create(x, y, FloorMaker)
            break
        case 3:
            if rng_random(0, 39 + instance_number(FloorMaker)) > 40 {
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
				
                instance_destroy()
            }
			
            if rng_random(0, 25) < 1
				instance_create(x, y, FloorMaker)
            break
        case 4:
        case 104:
            if (_area == 104 && rng_random(0, 4) >= 1) break
			
            if rng_random(0, 9 + instance_number(FloorMaker)) > 10 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
            }
			
            if rng_random(0, 4) < 1
				instance_create(x, y, FloorMaker)
			
            break
        case 5:
            if rng_random(0, 14 + instance_number(FloorMaker)) > 15 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x, y, Floor)
                    instance_create(x + 16, y + 16, AmmoChest)
                }
            }
			
            if rng_random(0, 15) < 1
				instance_create(x, y, FloorMaker)
			
            break
        case 6:
            if rng_random(0, 21 + instance_number(FloorMaker)) > 22 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x, y, Floor)
                    instance_create(x + 16, y + 16, AmmoChest)
                }
            }
			
            if rng_random(0, 20) < 1
				instance_create(x, y, FloorMaker)
			
            break
        case 7:
        case 102:
            if _area == 7 {
                if rng_random(0, 8 + instance_number(FloorMaker)) > 9 {
                    instance_destroy()
					
                    if point_distance(x, y, 10016, 10016) > 48 {
                        instance_create(x + 16, y + 16, AmmoChest)
                        instance_create(x, y, Floor)
                    }
                }
				
                if rng_random(0, 16) < 1
					instance_create(x, y, FloorMaker)
            }
            //
            if rng_random(0, 9 + instance_number(FloorMaker)) > 10 {
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x + 16, y + 16, AmmoChest)
                    instance_create(x, y, Floor)
                }
                instance_destroy()
            }
			
            if rng_random(0, 5) < 1
				instance_create(x, y, FloorMaker)
            break
        case 103:
        case 107:
            if rng_random(0, 31 + instance_number(FloorMaker)) > 32 {
                instance_destroy()
                if point_distance(x, y, 10016, 10016) > 48 {
                    instance_create(x, y, Floor)
                    instance_create(x + 16, y + 16, AmmoChest)
                }
            }
			
            if rng_random(0, 20) < 1
				instance_create(x, y, FloorMaker)
            break
    }
	
    if _area == 101 or _area == 105 {
        if rng_random(0, 19 + instance_number(FloorMaker)) > 20 {
            instance_destroy()
            if point_distance(x, y, 10016, 10016) > 48 {
                instance_create(x + 16, y + 16, AmmoChest)
                instance_create(x, y, Floor)
            }
        }
		
        if rng_random(0, 14) < 1
			instance_create(x, y, FloorMaker)
    }
}
