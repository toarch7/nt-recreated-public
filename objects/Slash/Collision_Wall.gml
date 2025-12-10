x -= hspeed
y -= vspeed

if speed > 2 {
    x += lengthdir_x(3, image_angle)
    y += lengthdir_y(3, image_angle)
}

if (walled || shank) exit

with other {
	var _cx = bbox_center_x,
		_cy = bbox_center_y,
		_angle = point_direction(other.x, other.y, _cx, _cy)
	
	with instance_create(_cx, _cy, MeleeHitWall) {
	    image_angle = _angle
	}
}

scr_screenshake(damage div 3)

walled = true

if guitar {
    var snd = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))
	
    if audio_exists(snd) {
        snd_play_pitch(snd, 0.2)
	}
}
else snd_play(sndMeleeWall)