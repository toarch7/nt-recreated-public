if lockstep_stop
	exit

image_index += (image_index < 1) ? random(0.04) : 0.4

if (speed > 0) exit

target = noone

if distance_to_object(ProtoStatue) < 170 && !collision_line(x, y, ProtoStatue.x, ProtoStatue.y, Wall, 0, 0) && ProtoStatue.hp < ProtoStatue.max_hp * 0.7 {
    target = instance_nearest(x, y, ProtoStatue)
}
else if distance_to_object(HostileHorror) < 170 && HostileHorror.charge <= 0 && !collision_line(x, y, HostileHorror.x, HostileHorror.y, Wall, 0, 0) {
    target = instance_nearest(x, y, HostileHorror)
}
else if instance_exists(Player) {
	var p = instance_nearest(x, y, Player),
		d = 80 + (60 * scr_skill_get(mut_plutonium_hunger))
	
    if ((distance_to_object(p) < d && !p.horrornorad) || instance_exists(Portal)) {
        target = instance_nearest(x, y, Player)
    }
}

if instance_exists(target) {
    direction = point_direction(x, y, target.x, target.y)
    mp_potential_step(target.x, target.y, 12, 0)
}

if (place_meeting(x, y, Player) || place_meeting(x, y, Portal)) {
    GameCont.rad += (object_index == BigRad) ? 10 : 1
        
    snd_play(sndRadPickup)
	
    with instance_create(x + orandom(3), y + orandom(3), RadEat) {
        if scr_skill_get(mut_plutonium_hunger) {
            sprite_index = (other.object_index == BigRad) ? sprEatBigRadPlut : sprEatRadPlut
        }
		else {
			sprite_index = (other.object_index == BigRad) ? sprEatBigRad : sprEatRad
		}
    }
    
	instance_destroy()
}