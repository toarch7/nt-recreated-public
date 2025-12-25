if lockstep_stop
	exit

with (other) {
	if (race != Race.Rogue) exit
	
	var _amount = 1 + scr_ultra_get(Race.Rogue, UltraSkill.SuperPortalStrike)
	
	rogue_ammo += _amount
	
	var _str = loc_fmt("+% PORTAL STRIKE" + (_amount > 1 ? "S" : ""), string(_amount))
	
	if (rogue_ammo >= rogue_ammo_max) {
		_str = loc("MAX PORTAL STRIKES")
		rogue_ammo = rogue_ammo_max
	}
	
	scrPopupCreate(x, y, _str)
}
snd_play(sndRogueCanister)
instance_destroy()