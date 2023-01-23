if sprite_index == sprRavenLift {
    sprite_index = sprRavenFly
    alarm[0] = max(point_distance(x, y, targetx, targety) / 6, 1)
} else if sprite_index == sprRavenLand {
    /*if !place_free(x, y) {
        nofly = 0
        flor = instance_nearest(x, y, Floor)
        
        if instance_exists(flor) {
            x = flor.x
            y = flor.y
        }
        
        scrRavenLift()
    } else {
        */
    repeat(6) {
        with instance_create(x + random(16) - 8, y + random(16), Dust)
        motion_add(random(360), 3 + random(1))
    }

    scrTarget()

    if instance_exists(target) {
        with Raven {
            if point_distance(x, y, other.x, other.y) < 120 and point_distance(x, y, other.x, other.y) > 32 {
                if collision_line(other.target.x, other.target.y, x, y, Wall, 1, 1) < 0 and random(3) < 2 scrRavenLift()
            }
        }
    }

    z = 0
    alarm[1] = 20 + random(10)
    alarm[2] = -1

    if x > view_xview and y > view_yview and x < view_xview + view_width and y < view_yview + view_height snd_play(sndRavenLand)

    instance_change(Raven, false)
    //}
}