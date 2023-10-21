if lockstep_stop
	exit

if (instance_number(enemy) < (enemies * spawnmoment) or !scr_check_enemies()) && canspawn {
    with WantVan
		canspawn = 0
	
    instance_create(x, y, VanSpawn)
	
    instance_destroy()
}