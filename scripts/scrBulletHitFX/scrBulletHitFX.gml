/// @function scrBulletHitFX
/// @param sprite=sprBulletHit
function scrBulletHitFX(_sprite = sprBulletHit) {
	with instance_create(x, y, BulletHit) {
		sprite_index = _sprite
		image_angle = other.image_angle
		
		if other.image_speed != 0 {
			image_speed = other.image_speed
		}
		
		return id
	}
	
	return noone
}