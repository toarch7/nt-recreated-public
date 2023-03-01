function scrRadDrop(raddrop) {
	var p = instance_nearest(x, y, Player)
	
	do {
		if raddrop >= 15 {
			raddrop -= 10
			
			with instance_create(x, y, BigRad) {
				motion_add(other.direction, other.speed)
				motion_add(random(360), random(raddrop / 2) + 5)
				
				repeat speed
				speed *= 0.9
				
				if instance_exists(p) && p.race == 11 && ultra_get(1) {
				    repeat 4 {
					    with instance_create(x, y, HorrorBullet) {
					        creator = p.id
					        direction = other.direction + random_range(-8, 8)
							
							if instance_exists(creator) && creator.bskin
								sprite_index = sprHorrorBullet2
							
					        speed = 9
					        image_angle = direction
					        team = creator.team
					    }
					}
				}
			}
		}
	} until raddrop <= 15
	
	repeat raddrop {
		with instance_create(x, y, Rad) {
			motion_add(other.direction, other.speed)
			motion_add(random(360), random(raddrop / 2) + 5)
			
			repeat speed
			speed *= 0.9
			
			if instance_exists(p) && p.race == 11 && ultra_get(1) {
			    with instance_create(x, y, HorrorBullet) {
			        creator = p.id
			        direction = other.direction
					
			        if instance_exists(creator) && creator.bskin
						sprite_index = sprHorrorBullet2
					
			        speed = 9
			        image_angle = direction
			        team = creator.team
			    }
			}
		}
	}
}