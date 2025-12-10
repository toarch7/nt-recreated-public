if test_switchup_time > current_frame {
	if scr_weapon_is_auto(current_weapon_id) {
		with Player {
			if (reload > 20) reload = 20
			if (!reload) scrFire(wep)
			
			KeyCont.dir_fire[index] += 2
		}
	}
	
	exit
}

if instance_exists(damagesource) || instance_exists(SentryGun) || current_frame < test_switchup_time exit

if started {
	current_weapon_id ++
	
	if current_weapon_id >= maxwep {
		print("Complete!")
		instance_destroy()
		exit
	}
}
else started = true

print(++ count, "weapon:", scr_weapon_get_name(current_weapon_id))

scr_test_create_arena()

with (Player) {
	for(var i = 1; i <= 5; ++i) {
		ammo[i] = scrAmmoGetTypeCapacity(i)
	}
	
	can_die = false
	can_walk = false
	can_aim = false
	can_shoot = false
	can_spec = false
	roll = false
	hp = max_hp
	gunangle = random(360)
	KeyCont.dir_fire[index] = gunangle
	wep = other.current_weapon_id
	scrFire(wep)
}

test_switchup_time = current_frame + 1
