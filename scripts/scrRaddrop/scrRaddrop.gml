/// @function scrRadDrop
/// @param x
/// @param y
/// @param amount
function scrRadDrop(_x, _y, _amount) {
	var _high = instance_is(self, RadChest) ? 26 : 15
	
	while _amount >= _high {
		_amount -= 10
		
		with instance_create(_x, _y, BigRad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(_amount * 0.5) + 5)
			
			repeat (speed) speed *= 0.9
			
			repeat (4) scrStalkerProc()
		}
	}
	
	repeat _amount {
		with instance_create(_x, _y, Rad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(_amount * 0.5) + 5)
			
			repeat (speed) speed *= 0.9
			
			scrStalkerProc()
		}
	}
}

function scrStalkerProc() {
	var _x = x, _y = y, _direction = direction
	
	with Player {
		if race != Race.Horror continue
		
		var _stalker = scrUltraCheck(race, UltraSkill.Stalker)
		
		if _stalker <= 0 break
		
		with instance_create(_x, _y, HorrorBullet) {
			team = other.team
			creator = other.id
			
			direction = _direction
			speed = 9
			
			if other.bskin {
				sprite_index = sprHorrorBBullet
			}
			
			image_angle = _direction
		}
			
		snd_play_hit(sndHorrorA)
	}
}