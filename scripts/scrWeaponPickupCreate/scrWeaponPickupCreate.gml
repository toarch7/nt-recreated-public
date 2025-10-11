/// @function scrWeaponPickupCreate
/// @param x
/// @param y
/// @param weapon
/// @param has_ammo=false
function scrWeaponPickupCreate(_x, _y, _weapon, _has_ammo = false) {
	with instance_create(_x, _y, WepPickup) {
		if _has_ammo && scr_weapon_get_type(_weapon) != Ammo.None {
			ammo = true
		}
		
	    wep = _weapon
	    name = scr_weapon_get_name(_weapon)
	    type = scr_weapon_get_type(_weapon)
	    sprite_index = scr_weapon_get_sprite(_weapon)
	    image_angle = random_angle
		
		return id
	}
	
	return noone
}