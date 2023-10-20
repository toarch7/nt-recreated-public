repeat(1 + GameCont.loops) {
    ang = random_angle
    with(instance_create((x + lengthdir_x((60 + random(100)), ang)), (y + lengthdir_y((60 + random(100)), ang)), Turret)) {
        GameCont.kills -= 1
        dir = instance_nearest(x, y, Floor)
        x = (dir.x + 16)
        y = (dir.y + 16)
    }
}