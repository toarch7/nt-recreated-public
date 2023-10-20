if (spr_idle == sprPalaceGuardianAppear) {
    meleedamage = 2
    spr_idle = sprPalaceGuardianIdle
}

if (spr_idle == sprPalaceGuardianDisappear) {
    meleedamage = 0
    snd_play(sndGuardianAppear)
    spr_idle = sprPalaceGuardianAppear
    if (instance_exists(target)) {
        dist = (64 + random(120))
        do {
            angle = random_angle
            myx = (target.x + lengthdir_x(dist, angle))
            myy = (target.y + lengthdir_y(dist, angle))
        } until ((point_distance(target.x, target.y, ((instance_nearest(myx, myy, Floor)).x + 16), ((instance_nearest(myx, myy, Floor)).y + 16)) > (dist * 0.7)) && ((point_distance(x, y, myx, myy) > 32) && (!place_meeting(myx, myy, Nothing))));

        x = ((instance_nearest(myx, myy, Floor)).x + 16)
        y = ((instance_nearest(myx, myy, Floor)).y + 16)
        move_contact_solid((200 + random(140)), (100 + random(60)))
    }
}