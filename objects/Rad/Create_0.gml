friction = 0.2
image_angle = random(360)


blink = 30
alarm[0] = 150 + random(30)

//RUSH CROWN
if instance_exists(Player) {
    if GameCont.crown = 4 alarm[0] /= 3
}

image_index = random(7)
image_speed = 0

if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    if p.race == 15 && ultra_get(1) && irandom(3) == 1 {
        instance_create(x, y, ToxicGas)
    }
}

depth = 1