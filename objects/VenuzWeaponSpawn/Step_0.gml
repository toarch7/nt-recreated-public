if lockstep_stop
	exit

with instance_create(x, y, WepPickup) {
    curse = 0
    scrDecideWep(6)
    name = wep_name[wep]
    other.wep = wep
    ammo = 50
    type = wep_type[wep]
    sprite_index = wep_sprt[wep]
    motion_add(random_angle, 10)
}