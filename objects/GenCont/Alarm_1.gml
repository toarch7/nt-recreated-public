/// @description Finalize level structure

scrMoveTopPots()

if (instance_exists(Player)) {
    with (CrownObject) if (is_new) {
        if (!(GameCont.area == area_palace && GameCont.subarea == GameCont.maxsubarea)) {
            instance_create(x, y, IDPDSpawn)
        }
		
        is_new = false
    }
	
	instance_destroy(GammaGuts)
	
    with (Player) {
		x = 10016
        y = 10016
		xprevious = x
		yprevious = y
		angle = 0
		
		if (is_me) {
			drawempty = 30
			drawlowhp = 30
			
			scr_camera_set_position(x, y, fa_center, fa_middle)
		}
		
		if (scr_skill_get(mut_gamma_guts)) {
		    with (instance_create(x, y, GammaGuts)) {
		        creator = other.id
				team = other.team
		    }
		}
	}
	
	with (TopPot) {
		if (place_meeting(x, y, PortalClear)) instance_destroy(id, false)
	}
	
    if (!instance_exists(Cinematic)) {
		with (instance_random(Player)) {
	        if (GameCont.area == area_vault) {
	            snd_play(snd_valt)
	        }
			else if (GameCont.subarea == 1) {
	            snd_play(snd_wrld)
				
	            if (GameCont.area == area_hq) {
	                var _sound = asset_get_index("sndMutant" + string(race) + "IDPD")
	                if (audio_exists(_sound)) snd_play(_sound, 0.1)
	            }
	        }
	    }
	}
}

with (WepPickup) if (persistent) {
	x = 10016
	y = 10016
	xprevious = x
	yprevious = y
    visible = true
    persistent = false
	mask_index = mskWepPickup
	motion_add(random_angle, 1.5 + random(1))
}

with (CrownPickup) {
    with (Torch) {
        if (point_distance(x, y, other.x, other.y) < 240) instance_destroy(id, false)
    }
}

instance_activate_object(Bones)

if (GameCont.area == area_cursed_caves) {
	with (WeaponChest) {
		instance_create(x, y, CursedBigChest)
		instance_destroy(id, 0)
	}
	
    with (BigWeaponChest) {
		instance_create(x, y, CursedBigChest)
		instance_destroy(id, 0)
    }
}
else if (GameCont.area == area_mansion) {
	with (WeaponChest) {
		instance_create(x, y, GoldChest)
		instance_destroy(id, false)
	}
}

with (Wall) {
	mcr_wall_update_lrwh;
	visible = place_meeting(x, y + 16, Floor)
}

instance_destroy()