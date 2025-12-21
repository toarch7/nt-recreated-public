event_inherited()

if speed == 0 timeout += timescale

if timeout > (40 + (GameCont.loops * 10)) instance_destroy()

if timeout > 15 {
    if sound {
        snd_play_hit_big(sndNothing2Beam, 0.1)
		sound = false
    }
	
    with scr_projectile_create(x, y, EnemyBullet2, angle, 10) {
		sprite_index = sprHorrorBullet
		image_angle = direction
	}
}
else if instance_exists(Player) && speed == 0 {
    var _target = instance_nearest(x, y, Player)
    
	angle = point_direction(x, y, _target.x, _target.y) + orandom(30)
	
    with(instance_create(x, y, IDPDPortalCharge)) {
        move_contact_solid(random_angle, (16 + random(32)))
        sprite_index = sprNothingBeamParticle
        alarm[0] = 10
		
		var _dir = point_direction(x, y, xstart, ystart),
			_spd = point_distance(x, y, xstart, ystart) / 20
        
		motion_add(_dir, _spd)
		image_angle = direction
    }
}