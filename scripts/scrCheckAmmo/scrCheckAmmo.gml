function scrCheckAmmo(wep, mult = 1) {
	return wep_cost[wep] <= 0 or (ammo[wep_type[wep]] >= wep_cost[wep] * mult)
}

function scrCheckRads(wep, mult = 1) {
	return wep_rads[wep] <= 0 or (GameCont.rad >= wep_rads[wep] * mult)
}

function scrCheckCanShoot(wep, mult = 1) {
	return scrCheckAmmo(wep, mult) && scrCheckRads(wep, mult)
}