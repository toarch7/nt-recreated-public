/// @description Store weapon

if (instance_exists(Player) && sprite_index != sprProtoChest) {
	var _p = instance_nearest(x, y, Player)
	
	if point_distance(x, y, _p.x, _p.y) > 32 {
		sprite_index = sprProtoChest
		
		wep = other.wep
		curse = other.curse
		
		instance_destroy(other)
	}
}
