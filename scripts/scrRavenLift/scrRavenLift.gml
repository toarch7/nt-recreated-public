function scrRavenLift() {
    if object_index != Raven exit

    if nofly <= 0 {
        repeat 6 {
            with instance_create(x + random(16) - 8, y + random(16), Dust) {
                motion_add(random(360), 3 + random(1))
            }
        }

        if x > view_xview && y > view_yview && x < view_xview + view_width && y < view_yview + view_height {
            snd_play(sndRavenLift)
        }

        z = 0
        scrTarget()

        if instance_exists(target) {
            do {
                targetx = x + lengthdir_x(128, point_direction(mouse_x, mouse_y, target.x, target.y) + random(50) - 25)
                targety = y + lengthdir_y(128, point_direction(mouse_x, mouse_y, target.x, target.y) + random(50) - 25)

                var dir;
                dir = instance_nearest(targetx, targety, Floor)

                targetx = dir.x + 16 + random(96) - 48
                targety = dir.y + 16 + random(96) - 48

                dir = instance_nearest(targetx, targety, Floor)

                targetx = dir.x + 16
                targety = dir.y + 16
            } until place_free(targetx, targety)
        }

        if point_distance(x, y, targetx, targety) > 16 {
            image_index = 0
            nofly = 50
            instance_change(RavenFly, false)
            lifespan = 300
        }
    }
}