if speed > 16 {
    speed = 16
}

if position_empty(x + hspeed, y + vspeed) {
    x -= hspeed
    y -= vspeed
}

move_bounce_solid(false)