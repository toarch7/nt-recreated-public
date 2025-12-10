function scrBloodAmmoRefill(wep) {
	ammo[wep_type[wep]] += wep_cost[wep]
	scr_hit_self(1)
}