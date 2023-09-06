if lockstep_stop
	exit

var p = instance_nearest(x, y, Player)

if !p or p.race != 12
	exit

with p {
	var a = 1 + (ultra == 1)
	
    with instance_create(x, y, PopupText)
		mytext = loc_sfmt("+% PORTAL STRIKE" + (a > 1 ? "S" : ""), string(a))
	
    rogue_ammo += a
}

snd_play(sndRogueCanister)

instance_destroy()
