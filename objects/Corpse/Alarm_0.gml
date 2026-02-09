if (
	instance_exists(Portal) || instance_exists(GenCont) || (!forceportal && scr_check_enemies()) || GameCont.area == area_crib || instance_exists(RadMaggotChest)
	|| instance_exists(CrownGuardian) || instance_exists(VaultStatue) || instance_exists(CrownPickup) || instance_exists(TutCont) || !instance_exists(Player)
	|| instance_exists(BecomeScrapBoss) || ((GameCont.area == area_palace || GameCont.area == area_hq) && GameCont.subarea == GameCont.maxsubarea)
	|| instance_exists(SitDown)
) {
	exit
}

if GameCont.area == area_campfire {
	if !instance_exists(IDPDSpawn) && !(instance_exists(Nothing2Appear) || instance_exists(Nothing2) || instance_exists(NothingSpiral)) {
	    instance_create(x, y, Nothing2Appear)
	}
}
else {
	if !place_meeting(x, y, Floor) {
	    with (instance_nearest(x, y, Floor)) {
			other.x = bbox_center_x
			other.y = bbox_center_y
		}
	}
	
	with instance_create(x, y, Portal) {
	    type = 1
		
	    if GameCont.area == area_hq {
	        type = 2
	    }
	}
}