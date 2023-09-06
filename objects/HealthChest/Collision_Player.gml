if lockstep_stop
	exit

if !instance_exists(GenCont) {
	if scrChestOpened()
		exit
	
	var num = self.num,
		p = instance_nearest(x, y, Player)

	with other {
	    if headloses {
	        headloses --
	        max_hp ++
	    }
	}
	
	instance_create(x, y, FXChestOpen)
	
	if skill_get(9) {
	    snd_play(sndHealthChestBig)
	}
	else snd_play(sndHealthChest)
	
	instance_create(x, y, HealFX)
	
	p.hp += num
	
	if p.hp > p.max_hp
		p.hp = p.max_hp
	
	var dir = instance_create(x, y, PopupText)
	dir.mytext = "+" + string(num) + " HP"
	
	if p.hp >= p.max_hp
		dir.mytext = "MAX HP"
	
	snd_play(sndHealthChest)
	instance_destroy()
}

