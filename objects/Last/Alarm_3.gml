scrTarget()
if (instance_exists(target)) {
    do {
        tarx = ((target.x + random(320)) - 160)
        tary = ((target.y + random(320)) - 160)
    } until ((point_distance(tarx, tary, target.x, target.y) > 80) && ((point_distance(tarx, tary, x, y) > 60) && (place_meeting(tarx, tary, Floor) && place_free(tarx, tary))));

    snd_play_hit_big(sndLastTeleport, 0)
    Last.x = ((instance_nearest(tarx, tary, Floor)).x + 16)
    Last.y = ((instance_nearest(tarx, tary, Floor)).y + 16)
    instance_create(x, y, PortalClear)
    drawspr = sprLastWarpIn
    drawimg = 0
    alarm[5] = 20
} else {
    instance_create(x, y, PortalClear)
    drawspr = sprLastWarpIn
    snd_play_hit_big(sndLastTeleport, 0)
    drawimg = 0
    alarm[5] = 20
}