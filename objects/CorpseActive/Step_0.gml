if lockstep_stop
	exit

if !speed {
    var s = sprite_index
    var i = image_index
    var spd = image_speed

    instance_change(Corpse, 0)

    sprite_index = s
    image_index = i
    image_speed = spd
}