if lockstep_stop
	exit

var p = instance_nearest(x, y, Player)

if !p or p.race != 12
	exit

with p {
	var a = 1 + (ultra == 1)
	
    rogue_ammo += a
	
	var str = loc_sfmt("+% PORTAL STRIKE" + (a > 1 ? "S" : ""), string(a))
	
	if rogue_ammo >= rogue_ammo_max {
		str = loc("MAX PORTAL STRIKES")
		rogue_ammo = rogue_ammo_max
	}
	
    with instance_create(x, y, PopupText)
		mytext = str
}

snd_play(sndRogueCanister)

instance_destroy()
