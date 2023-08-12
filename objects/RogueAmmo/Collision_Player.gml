var p = instance_nearest(x, y, Player)

if !p or p.race != 12
	exit

with p {
    var amount = 1 + (ultra == 1)
	
    if rogue_ammo < rogue_ammo_max {
        with instance_create(x, y, PopupText)
        mytext = "+" + string(amount) + " PORTAL STRIKE" + qm(amount > 1, "S", "")
        
        rogue_ammo += amount
    }
	else {
		with instance_create(x, y, PopupText)
			mytext = "MAX PORTAL STRIKES"
	}
}

instance_destroy()
snd_play(sndRogueCanister)

