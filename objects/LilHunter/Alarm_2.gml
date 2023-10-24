if !hp exit

if instance_exists(Player) {
    var p = instance_nearest(x, y, Player)

    if !p.speed {
        alarm[2] = 2
    }
	else {
        sprite_index = sprLilHunterLiftStart
        image_index = 0
		
        instance_change(LilHunterFly, 0)
        snd_play(sndLilHunterLaunch)
    }
}
else {
    sprite_index = sprLilHunterLiftStart
    image_index = 0
    instance_change(LilHunterFly, 0)
    snd_play(sndLilHunterLaunch)
}