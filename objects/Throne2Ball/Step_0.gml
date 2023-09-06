if lockstep_stop
	exit

event_inherited()
if (speed == 0) timeout += 1
if (timeout > (40 + (GameCont.loops * 10))) instance_destroy()
if (timeout > 15) {
    if (timeout == 16) {
        snd_play_hit_big(sndNothing2Beam, 0.1)
    }
    with(instance_create(x, y, EnemyBullet2)) {
        sprite_index = sprHorrorBullet
        team = other.team
        hit_id = other.hit_id
        motion_add(other.angle, 10)
        image_angle = direction
        team = other.team
    }
} else if (instance_exists(Player) && (speed == 0)) {
    dir = instance_nearest(x, y, Player)
    angle = ((point_direction(x, y, dir.x, dir.y) + random(60)) - 30)
    with(instance_create(x, y, IDPDPortalCharge)) {
        move_contact_solid(random(360), (16 + random(32)))
        sprite_index = sprBeamParticles
        alarm[0] = 10
        motion_add(point_direction(x, y, xstart, ystart), (point_distance(x, y, xstart, ystart) / 20))
        image_angle = direction
    }
}