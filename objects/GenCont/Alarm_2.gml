/// @description Spawn in vaults & crib chests

var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops

if GameCont.area == area_vault {
    with instance_furthest(10016, 10016, Floor)
    instance_create(x + 16, y + 16, CrownPickup)
}
else if (GameCont.crownvisits < 3 && !instance_exists(ProtoStatue) && instance_exists(Floor)) {
	var _max_subarea = scrAreaGetMaxSubarea(_area),
		_middle = min(_max_subarea - 1, ceil(_max_subarea / 2))
	
	if (_subarea == _middle && _subarea != _max_subarea
		&& ((_loops && (_area == area_desert || _area == area_palace)) || _area == area_scrapyards || _area == area_city)
	) {
		var _floor = instance_furthest(10016, 10016, Floor),
			_tx = (_floor.x * 2 + 10016) * 0.33 + orandom(64),
			_ty = (_floor.y * 2 + 10016) * 0.33 + orandom(64)
		
		with (instance_nearest(_tx, _ty, Floor)) {
	        instance_create(bbox_center_x, bbox_center_y, ProtoStatue)
	    }
	}
}

if GameCont.area == area_crib {
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
		var _openmind = scr_skill_get(mut_open_mind), _dx = 90, _dy = 64;
		
		if (_openmind) _dx += _openmind * 32
		
		repeat (1 + _openmind) {
	        if (scrCrownCheck(crwn_love)) {
	            instance_create(((lowx + 16) - _dx), (lowy + _dy), GiantAmmoChest)
	            instance_create(((lowx + 16) + _dx), (lowy + _dy), GiantAmmoChest)
	        }
			else {
	            instance_create(lowx + 16 - _dx, lowy + _dy, GiantWeaponChest)
	            instance_create(lowx + 16 + _dx, lowy + _dy, GiantWeaponChest)
	        }
			_dy -= 28
			_dx -= 48
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

instance_destroy(Smoke)

with (SpiralCont) alarm[0] = 1