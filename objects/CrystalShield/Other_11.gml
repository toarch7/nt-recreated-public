/// @description Teleportation
if (instance_exists(creator) && scr_skill_get(mut_throne_butt)) {
	x = teleport_x
	y = teleport_y
	
	with (creator) {
		var _sprite = sprCrystTrail
		
		/**/ if (bskin == SkinLetter.B) _sprite = sprCrystTrailB
		else if (bskin == SkinLetter.C) _sprite = sprCrystTrailC
		
		repeat (6 + irandom(3)) {
	        with instance_create(x, y, AnimParticle) {
	            sprite_index = _sprite
	            image_speed = 0.4
	            friction = 0.4
	            depth = -7
				
	            motion_add(random_angle, 3 + random(2))
	        }
	    }
		
		x = other.x
		y = other.y
		
		if (place_meeting(x, y, Wall)) {
			with (instance_create(x, y, PortalClear)) {
				image_xscale = 0.25
				image_yscale = 0.25
			}
		}
		
	    xprevious = x
	    yprevious = y
	}
	
	snd_play(sndCrystalTB)
}