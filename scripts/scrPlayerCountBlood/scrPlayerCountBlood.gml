function scrPlayerCountBlood(_player) {
	return (scrCrownCheck(crwn_blood) != 0)
		 + (scr_skill_get(mut_bloodlust) != 0)
		 + (scr_ultra_get(Race.CoopUltra, UltraSkill.BloodBond) != 0)
		 + scrPlayerHasWeapon(_player, wep_blood_launcher, true)
		 + scrPlayerHasWeapon(_player, wep_blood_cannon, true)
		 + scrPlayerHasWeapon(_player, wep_blood_hammer, true)
}