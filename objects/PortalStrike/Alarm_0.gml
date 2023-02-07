if ammo {
    with instance_create(x + expl_x, y + expl_y, PopoExplosion) {
        if instance_exists(Player) {
            team = -1

            image_xscale -= 0.5
            image_yscale -= 0.5

            if skill_get(5) {
                image_xscale += 0.5
                image_yscale += 0.5

                repeat 4 + random(8) {
                    instance_create(x + lengthdir_x(random(48), random(360)), y + lengthdir_y(random(48), random(360)), BlueFlame)
                }
            }

            snd_play(sndIDPDNadeExplo)
        }
    }

    expl_x += lengthdir_x(32, direction)
    expl_y += lengthdir_y(32, direction)
	
    alarm[0] = 1
    ammo --
}
else instance_destroy()