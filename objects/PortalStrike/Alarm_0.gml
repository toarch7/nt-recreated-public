if !ammo {
	instance_destroy(); exit
}

with instance_create(x + expl_x + orandom(4), y + expl_y + orandom(4), PopoExplosion) {
    team = -1
	
    image_xscale -= 0.5
    image_yscale -= 0.5
	
    if skill_get(5) {
        image_xscale += 0.5
        image_yscale += 0.5
		
        repeat 4 + random(8)
            instance_create(x + lengthdir_x(random(48), random_angle), y + lengthdir_y(random(48), random_angle), BlueFlame)
    }
	
    snd_play(sndIDPDNadeExplo)
}

expl_x += lengthdir_x(28 + random(4), direction)
expl_y += lengthdir_y(28 + random(4), direction)

alarm[0] = 3

ammo --