if sprite_index == sprLilHunterLift {
    z -= 8
	
    if (y + z) < (view_yview - 64) && (-z) > 160 {
        if instance_exists(target) {
            x = target.x
            y = target.y
			
            if random(3) < 1 {
                ang = random(360)
                dir = instance_nearest(x + 16 + lengthdir_x(120, ang), y + 16 + lengthdir_y(120, ang), Floor)
                
				x = dir.x + random(32)
                y = dir.y + random(32)
            }
        }
		
        sprite_index = sprLilHunterLand
    }
}

if sprite_index == sprLilHunterHurt {
    sprite_index = sprLilHunterLiftStart
}

if sprite_index == sprLilHunterLand {
    z += 10
	
    if z >= 0 {
        BackCont.shake += 5
        snd_play(sndLilHunterLand)
        instance_create(x, y, PortalClear)
        firang = random(360)
		
        repeat 80 {
            firang += 4.5
			
            with instance_create(x, y, TrapFire) {
                hit_id = other.spr_idle
                sprite_index = sprFireLilHunter
                motion_add(other.firang, 2 + random(0.2))
                move_contact_solid(direction, 12)
                image_angle = direction
                team = other.team
            }
        }
		
        repeat 6 {
            with(instance_create(((x + random(16)) - 8), (y + random(16)), Dust))
            motion_add(random(360), (3 + random(1)))
        }
		
        z = 0
        alarm[1] = 20 + random(10)
		
        if intro == 0 {
            snd_play(sndLilHunterAppear)
            
			with(MusCont)
				alarm[2] = 1
			
            alarm[4] = 2
            scrBossIntro(2)
            intro = 1
        }
		
        spr_idle = sprLilHunterLandEnd
        sprite_index = spr_idle
        image_index = 0
        alarm[3] = 12.5
		
        instance_change(LilHunter, 0)

        alarm[6] = 5
    }
}