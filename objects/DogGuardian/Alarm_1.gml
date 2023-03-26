scrTarget()

alarm[1] = 30 + random(20)
spr_idle = sprDogGuardianWalk

if instance_exists(target) {
    motion_add(random(360), 0.5)
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        if point_distance(x, y, target.x, target.y) < 100 + random(60) && random(3) < 2 {
            bounced = 0
            spr_idle = sprDogGuardianCharge
            sprite_index = spr_idle
            image_index = 0
            speed = 0
            jumpdist = point_distance(x, y, target.x, target.y) * 1.1
            jumpdir = target_direction + orandom(20)
            alarm[2] = 10
            alarm[1] = 300
        } else motion_add(target_direction, 1.4)
    }
} else motion_add(random(360), 0.5)