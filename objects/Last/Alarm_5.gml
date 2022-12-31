if (drawspr == sprLastWarpIn) {
    snd_play_hit_big(sndLastTeleportShoot, 0)

    scrTarget()

    if (target > 0) {
        with(instance_create(x, y, LastBall)) {
            hit_id = other.hit_id
            team = other.team
            motion_add(point_direction(x, y, other.target.x, other.target.y), 6)
        }

        if target.x > x right = 1
        else right = -1
    }
}

drawspr = sprLastIdle
charge = 0

alarm[1] = 10 + (hp / max_hp) * 15