/// @description Spawn walls, bosses

with (Floor) mcr_floor_make_walls;

var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops

if instance_exists(Player) {
    view_xview = 10016 - view_width / 2
    view_yview = 10016 - view_height / 2

    with CrownObject {
        x = 10016
        y = 10016
        alarm[2] = 1
    }
}

var _max_subareas = scrAreaGetMaxSubareas(GameCont.area)

if (!(GameCont.subarea == _max_subareas && (GameCont.area == area_palace || GameCont.area == area_hq))) {
	scrPopulate()
	
	if (instance_exists(TutCont)) {
		with (enemy) {
			if (object_index != TutorialTarget) instance_destroy(id, false)
		}
		
		with (Wall) {
			if (place_meeting(x, y, Floor)) instance_destroy()
		}
		
		instance_destroy(chestprop, false)
		instance_destroy(RadChest, false)
		instance_destroy(WantBoss, false)
		instance_destroy(WantPopo, false)
	}
	
    with Floor {
        if GameCont.area == 0 && instance_exists(Player) && (rng_float(RNGStates.Enemies, 10 + GameCont.hard) > GameCont.hard or !instance_exists(IDPDSpawn)) {
            if instance_number(IDPDSpawn) < 5 + GameCont.loops instance_create(x + 16, y + 16, IDPDSpawn)
        }
    }
}
else {
	instance_destroy(chestprop, false)
	instance_destroy(RadChest, false)
}

if (GameCont.subarea == _max_subareas) {
	var _floor = instance_furthest(10000, 10000, Floor), _fx, _fy;
	
	if (instance_exists(_floor)) {
		with (_floor) {
			_fx = bbox_center_x
			_fy = bbox_center_y
		}
	}
	else {
		_fx = 10016
		_fy = 10016
	}
	
	if (GameCont.area == area_scrapyards) {
	    var _distance = point_distance(10016, 10016, _fx, _fy),
			_direction = point_direction(10016, 10016, _fx, _fy),
			_x = 10016 + lengthdir_x(_distance * 0.75, _direction),
			_y = 10016 + lengthdir_y(_distance * 0.75, _direction)
		
		with (instance_nearest(_x, _y, Floor)) {
		    with (instance_create(bbox_center_x, bbox_center_y, BecomeScrapBoss)) {
		        xprevious = x
		        yprevious = y
		    }
		}
	}
	else if (GameCont.area == area_city) {
		instance_create(_floor.x + 16, _floor.y + 16, LilHunter)
	}
	else if ((GameCont.area == area_caves || GameCont.area == area_cursed_caves) && GameCont.loops) {
		instance_create(_floor.x + 16, _floor.y + 16, HyperCrystal)
	}
	else if (GameCont.area == area_sewers && GameCont.loops) {
		instance_create(_floor.x + 16, _floor.y + 16, FrogQueen)
	}
}

with (Floor) mcr_floor_create_tops;

call_after(5, function() {
	with (Floor) mcr_floor_create_tops;
})

alarm[1] = 2