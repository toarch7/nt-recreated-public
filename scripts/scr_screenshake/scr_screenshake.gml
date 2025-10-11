function scr_screenshake(_amount) {
	with BackCont {
		shake += _amount * UberCont.opt_shake
	}
}

/// @function scr_weapon_post
/// @param camera_shift_direction
/// @param camera_shift_strength
/// @param screenshake_amount
/// @param recoil_amount=0
function scr_weapon_post(_direction, _shift, _shake, _recoil = 0) {
    with BackCont {
		var _screenshake_factor = UberCont.opt_shake
		viewx2 += lengthdir_x(shift, _direction + 180) * _screenshake_factor
		viewy2 += lengthdir_y(shift, _direction + 180) * _screenshake_factor
		shake += _shake * _screenshake_factor
	}
	
	if instance_is(self, Player) wkick = max(wkick, _recoil)
}