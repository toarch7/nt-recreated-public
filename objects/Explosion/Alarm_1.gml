/// @description Crown of Death smaller explosions

repeat 3 {
    var _angle = random_angle
	
    with instance_create(x + lengthdir_x(12, _angle), y + lengthdir_y(12, _angle), SmallExplosion) {
        hitid = other.hitid
        team = other.team
    }
}