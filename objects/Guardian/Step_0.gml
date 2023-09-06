if lockstep_stop
	exit

if ((spr_idle == sprPalaceGuardianDisappear) || (spr_idle == sprPalaceGuardianAppear)) speed = 0
event_inherited()
if (sprite_index != spr_hurt) motion_add(direction, 0.6)
if (sprite_index == spr_hurt) spr_idle = sprPalaceGuardianIdle
if (hspeed > 0) right = 1
else if (hspeed < 0) right = -1
if (speed > 0.6) speed = 0.6