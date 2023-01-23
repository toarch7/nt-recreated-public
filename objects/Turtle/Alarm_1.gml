alarm[1] = 50 + random(10)
scrTarget()
walk = 0

if instance_exists(target) {
    //GOT TARGET
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 and point_distance(x, y, target.x, target.y) < 320 {
        //CAN SEE
        direction = target_direction + random(60) - 30

        if random(3) < 2 walk = 50
        else alarm[1] /= 2
    } else {
        //CANT SEE
        direction = random(360)

        if random(4) < 1 walk = 50
        else alarm[1] /= 2
    }

}