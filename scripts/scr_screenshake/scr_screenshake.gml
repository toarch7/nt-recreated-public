function scr_screenshake(_amount) {
	with BackCont {
		shake += _amount * UberCont.opt_shake
	}
}

/// @function scr_weapon_post
/// @param camshift_dir
/// @param camshift_amount
/// @param screenshake=0
/// @param wkick=0
/// @param recoil=0
function scr_weapon_post(_direction, _shift, _shake = 0, _recoil = 0, _knockback = 0) {
	var _ctx = instance_is(self, projectileburst) ? creator : id
	
	with (_ctx) {
	    with BackCont {
			var _screenshake_factor = UberCont.opt_shake
			viewx2 += lengthdir_x(_shift, _direction) * _screenshake_factor
			viewy2 += lengthdir_y(_shift, _direction) * _screenshake_factor
			shake += _shake * _screenshake_factor
		}
		
		if instance_is(self, Player) wkick = _recoil
		if _knockback != 0 motion_add(_direction + 180, _knockback)
	}
}