if lockstep_stop
	exit

if (((instance_number(enemy) < (enemies * spawnmoment)) || (instance_number(enemy) == 0)) && (canspawn == 1)) {
    with WantVan
    canspawn = 0

    instance_create(x, y, VanSpawn)

    instance_destroy()
}