if ((spr_idle == sprGuardianDisappear) || (spr_idle == sprGuardianAppear)) speed = 0
event_inherited()
if (sprite_index != spr_hurt) motion_add(direction, 0.6)
if (sprite_index == spr_hurt) spr_idle = sprGuardianIdle
if (hspeed > 0) right = 1
else if (hspeed < 0) right = -1
if (speed > 0.6) speed = 0.6