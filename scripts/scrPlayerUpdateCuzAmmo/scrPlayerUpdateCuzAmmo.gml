function scrPlayerUpdateCuzAmmo() {
	cuz_ammo_max = 3 * (scr_skill_get(mut_back_muscle) + 1) * (scr_ultra_get(Race.Cuz, UltraSkill.Emotional) + 1)
}