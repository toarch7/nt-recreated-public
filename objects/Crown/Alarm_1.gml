if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    targetx = p.x + random(64) - 32
    targety = p.y + random(64) - 32
}

alarm[1] = 10 + random(40)