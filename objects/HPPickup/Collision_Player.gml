var p = instance_nearest(x, y, Player)

instance_create(x, y, HealFX)

instance_destroy()

if p.max_hp > 1 {
	p.hp += num
	
	if p.hp > p.max_hp
		p.hp = p.max_hp
	
	dir = instance_create(x,y,PopupText)
	dir.mytext = "+" + string(num) + " HP"
	
	if p.hp >= p.max_hp
		dir.mytext = loc("MAX HP")
}

instance_create(x, y, SmallChestPickup)

snd_play(skill_get(mut_second_stomach) ? sndHPPickupBig : sndHPPickup)

if GameCont.coopultra == 2 && alarm[0] != -1 {
	var plr = p.id
	alarm[0] = -1
	
	with Player {
		if id != plr {
			hp += p.num
			
			if hp > max_hp
				hp = max_hp
		}
	}
}