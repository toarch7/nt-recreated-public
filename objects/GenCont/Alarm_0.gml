/// @description Spawn walls, bosses

with (Floor) mcr_floor_make_walls;

var _area = GameCont.area,
	_subarea = GameCont.subarea,
	_loops = GameCont.loops

if instance_exists(Player) {
	scr_camera_set_position(10016, 10016, fa_center, fa_middle)
	
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

with (Floor) mcr_floor_create_tops;

call_after(5, function() {
	with (Floor) mcr_floor_create_tops;
})

alarm[1] = 2