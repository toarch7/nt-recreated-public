if lockstep_stop
	exit

if image_index = 0 && !instance_exists(BallMum) {
    image_index = 1
    with GameCont {
        area = 102
        subarea = 0
    }
    with enemy
    hp = 0
    with instance_create(x + 16, y + 16, Portal) type = 1
}