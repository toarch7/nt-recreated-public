alarm[1] = 30 + random(10)
scrTarget()
if target > 0 {
    if point_distance(x, y, target.x, target.y) < 100 {
        //charge
        walk = 40 + random(10)

        mydir = target_direction + random(20) - 10
        meleedamage = 4
        speed = 0.4

        if target.x < x right = -1
        else if target.x > x right = 1
    }
}