move_bounce_solid(00)
bounces += 1
if ((bounces > 3) && (speed > 0)) {
    alarm[2] = 15
    speed = 0
} else instance_create(x, y, PortalClear)