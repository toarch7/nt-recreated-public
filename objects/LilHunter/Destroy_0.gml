if hp > 0
	exit

scrDrop(200, 0)

corpse = false

event_inherited()

instance_create(x, y, PortalClear)

with instance_create(x, y, LilHunterDie) {
    hit_id = sprLilHunterHurt
    team = other.team
}

with MusCont alarm[1] = 1

with instance_create(x, y, Explosion)
	hit_id = other.hit_id

var firang = random_angle

repeat 80 {
    firang += 4.5
	
    with instance_create(x, y, TrapFire) {
        hit_id = other.spr_idle
        sprite_index = sprFireLilHunter
        motion_add(firang, 2 + random(0.2))
        move_contact_solid(direction, 12)
        image_angle = direction
        team = other.team
        hit_id = other.spr_idle
    }
}

if instance_exists(Player) {
    with Player {
	    if is_me {
	        UberCont.ctot_kill[race] ++
			
			if race == 12
				UberCont.ctot_uniq[race] ++
		}
		
		if race == 4
			other.raddrop ++
	}
}

scrAchievement(32)