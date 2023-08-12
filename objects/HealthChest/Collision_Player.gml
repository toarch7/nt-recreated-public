if !instance_exists(GenCont) {
	if scrChestOpened()
		exit
	
	var num = self.num

	with other {
	    if headloses {
	        headloses --
	        max_hp ++
	    }
	}

	instance_create(x, y, HealFX)
	
	other.hp += num
	if other.hp > other.max_hp
		other.hp = other.max_hp
	
	var dir = instance_create(x, y, PopupText)
	dir.mytext = "+" + string(num) + " HP"
	
	if other.hp >= other.max_hp
		dir.mytext = "MAX HP"
	
	snd_play(sndHealthChest)
	instance_destroy()
}

