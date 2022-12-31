if !roll {
    move_contact_solid(direction, max(1, median(6, speed, 0)))

    if !place_free(x + hspeed, y) {
        hspeed /= 2

        if !place_free(x + hspeed, y) hspeed = 0
    }

    if !place_free(x, y + vspeed) {
        vspeed /= 2

        if !place_free(x, y + vspeed) vspeed = 0
    }
} else {
    move_bounce_solid(1)
    angle += (720 - abs(angle)) * right * 0.7
}