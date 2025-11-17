function scrRadDrop(raddrop) {
	var p = instance_nearest(x, y, Player),
		high = 15
	
	if instance_is(self, RadChest)
		high = 26
	
	while raddrop >= high {
		raddrop -= 10
		
		with instance_create(x, y, BigRad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(raddrop / 2) + 5)
			
			repeat speed
				speed *= 0.9
			
			repeat 4 {
				scrStalkerProc()
			}
		}
	}
	
	repeat raddrop {
		with instance_create(x, y, Rad) {
			motion_add(other.direction, other.speed)
			motion_add(random_angle, random(raddrop / 2) + 5)
			
			repeat speed
			speed *= 0.9
			
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