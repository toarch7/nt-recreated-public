if lockstep_stop
	exit

if (instance_exists(NothingInactive) || instance_exists(BecomeNothing) || instance_exists(NothingDeath)) {
    instance_destroy(id, false)
    exit
}

var _is_idle = (sprite_index == sprPortal || sprite_index == sprProtoPortal || sprite_index == sprPopoPortal)

if instance_exists(Player) {
	var _player = instance_nearest(x, y, Player)
	if (instance_exists(_player) && _player.x != x) {
		image_xscale = sign(_player.x - x)
	}
	
    if (_is_idle) {
		self.attract_objects(WepPickup, 96)
		self.attract_objects(Player, 96)
    }
}

if (endgame < 100) {
    endgame -= timescale
	
    if (endgame < 0 && _is_idle) {
        if (type == 1) sprite_index = sprPortalDisappear
        if (type == 2) sprite_index = sprPopoPortalDisappear
        if (type == 3) sprite_index = sprProtoPortalDisappear
		
		image_index = 0
        
		with (Player) {
            visible = false
            roll = false
            angle = 0
        }
    }
}
if (!instance_exists(Player)) {
    endgame = -1
	
    if (endgame < 0 && _is_idle) {
        if (type == 1) sprite_index = sprPortalDisappear
        if (type == 2) sprite_index = sprPopoPortalDisappear
        if (type == 3) sprite_index = sprProtoPortalDisappear
        image_index = 0
    }
}

if (current_frame_active && random(20) < 1) scrFX(x, y, PortalL, random_angle, 2)
