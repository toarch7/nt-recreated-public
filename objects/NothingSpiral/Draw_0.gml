if lockstep_stop
	exit

scrDrawSpiral()

with (Floor) {
    if object_index != FloorExplo && (!place_meeting(x, y + 32, Floor) || !place_meeting(x - 32, y, Floor) || !place_meeting(x + 32, y, Floor)) {
        draw_sprite(sprBackFloor2, image_index, x, y)
	}
}

with (Floor)
{
    if (object_index != FloorExplo) {
        draw_sprite(sprBackFloor, image_index, x, y)
	}
    else {
        draw_sprite(sprBackFloorSmall, image_index, x, y)
	}
}