/// @function scrRadDrop
/// @param x
/// @param y
/// @param amount
/// @param big_chunks=true
/// @param proc_stalker=true
function scrRadDrop(_x, _y, _amount, _can_big = true, _can_stalker = true) {
	var _high = instance_is(self, RadChest) ? 26 : 15
	
	if (_can_big) while (_amount > _high) {
		_amount -= 10
		
		with instance_create(_x, _y, BigRad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(_amount * 0.5) + 5)
			
			repeat (speed) speed *= 0.9
			
			repeat (4) scrStalkerProc()
		}
	}
	
	repeat (_amount) {
		with instance_create(_x, _y, Rad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(_amount * 0.5) + 5)
			
			repeat (speed) speed *= 0.9
			
			if (_can_stalker) scrStalkerProc()
		}
	}
}

function scrStalkerProc() {
	if (!scr_ultra_get(Race.Horror, UltraSkill.Stalker)) exit
	
	var _x = x, _y = y, _direction = direction
	
	with Player {
		if (race != Race.Horror) continue
		
		with scr_projectile_create(_x, _y, HorrorBullet, _direction, 9) {
			/**/ if (other.bskin == SkinLetter.B) sprite_index = sprHorrorBBullet
			else if (other.bskin == SkinLetter.C) sprite_index = sprHorrorCBullet
		}
			
		snd_play_hit(sndHorrorA)
	}
}