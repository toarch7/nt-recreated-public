if lockstep_stop
	exit

if !instance_exists(GenCont) {
    if scrChestOpened() exit
    instance_create(x, y, VenuzAmmoSpawn)
    snd_play(sndBigWeaponChest)
    with (instance_nearest(x, y, Player)) {
		snd_play(snd_chst)
	}
    instance_destroy()
}

