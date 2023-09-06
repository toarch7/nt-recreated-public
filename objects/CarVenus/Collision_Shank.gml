if lockstep_stop
	exit

//MAGIC REPAIR
var p = instance_nearest(x, y, Player)

if instance_exists(p) {
    if p.wep == 27 or p.wep == 101 {
        hp = max_hp
        screwed = 1
        snd_loop(sndCarLoop)

        with instance_create(x, y, CarVenusFixed) {
            sprite_index = sprVenusCarFix
        }

        instance_destroy(id, 0)
    }
}