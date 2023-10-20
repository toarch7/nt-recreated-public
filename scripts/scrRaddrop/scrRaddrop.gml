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
	var drop = id
	
	with Player {
		if race != 11 or !ultra_get(1)
			continue
		
		with instance_create(drop.x, drop.y, HorrorBullet) {
			creator = other.id
			direction = drop.direction
				
			if other.bskin
				sprite_index = sprHorrorBullet2
				
			speed = 9
			image_angle = direction
			team = other.team
		}
	}
}