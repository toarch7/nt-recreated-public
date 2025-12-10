if place_meeting(x, y, Floor) scrDrop(100, 0)

snd_play(sndBigBallExplo)

instance_create(x, y, PortalClear)

var _ang = random_angle, _spd = 4

repeat 8 {
	repeat 10 {
		with scr_projectile_create(x, y, IDPDBullet, _ang, _spd) {
			image_angle = direction
		}
		
		_ang += 36
	}
	
	_spd += 0.6
}