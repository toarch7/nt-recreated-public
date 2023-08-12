if scrChestOpened()
	exit

var p = instance_nearest(x, y, Player)

if !p
	exit

if p.race != 12 {
    repeat 25 {
        with instance_create(x, y, Rad)
        motion_add(random(360), random(5))
    }
}
else with p {
    amount = 1 + (ultra == 1)
	
    if rogue_ammo < rogue_ammo_max {
        with instance_create(x, y, PopupText)
        mytext = "+" + string(other.amount) + " PORTAL STRIKE" + qm(other.amount > 1, "S", "")
        
        rogue_ammo += amount
    }
	else {
		with instance_create(x, y, PopupText)
			mytext = "MAX PORTAL STRIKES"
	}
}

snd_play(sndRogueCanister)
instance_destroy()

