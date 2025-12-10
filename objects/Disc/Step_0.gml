if lockstep_stop
	exit

if (current_frame_active) instance_create(x, y, DiscTrail)

dist += timescale

if instance_exists(enemy) && scr_skill_get(mut_bolt_marrow) {
    var _target = instance_nearest(x, y, enemy)
	
    if speed > 0 && point_distance(x, y, _target.x, _target.y) < 32 {
        x += lengthdir_x(1, point_direction(x, y, _target.x, _target.y))
        y += lengthdir_y(1, point_direction(x, y, _target.x, _target.y))
    }
}

if (alarm[0] == -1 && team != team_none) alarm[0] = 4
