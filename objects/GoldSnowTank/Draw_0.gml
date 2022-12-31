if ammo > 0 {
    lasx = x
    lasy = y
    lasd = 0

    do {
        lasd += 1
        lasx += lengthdir_x(2, gunangle)
        lasy += lengthdir_y(2, gunangle)
    } until position_meeting(lasx, lasy, Wall) || lasd > 1000

    draw_sprite_ext(sprLaserSight, - 1, x, y, ((point_distance(x, y, lasx, lasy) / 2) + 2), 1, gunangle, c_white, 1)
}

draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)