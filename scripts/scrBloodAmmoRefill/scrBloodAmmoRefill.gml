function scrBloodAmmoRefill(wep) {
	ammo[wep_type[wep]] += wep_cost[wep]
	projectile_hit_self(1)
}