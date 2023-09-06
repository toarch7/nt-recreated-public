if lockstep_stop
	exit

if instance_exists(Player) {
    if GameCont.area = 5 and !instance_exists(GenCont) and !instance_exists(LevCont) and !instance_exists(FloorMaker) {
        //SNOW & ICE TEST
        if instance_nearest(x - 16, y - 16, Floor).styleb = 1 friction = 0.05
        else friction = 1.5
    } else if friction != 1.5 friction = 1.5
} else if friction != 1.5 friction = 1.5

if sprite_index != spr_hurt
    sprite_index = spr_idle

if sprite_index = spr_hurt {
    if image_index > 2 sprite_index = spr_idle
}


if hp <= 0 instance_destroy()

if speed > 4 speed = 4

if inframes inframes--