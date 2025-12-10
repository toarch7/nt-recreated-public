if lockstep_stop
	exit

if other.canfix {
    snd_play_loop(sndCarLoop)
	
    with instance_create(x, y, CarVenusFixed) {
        sprite_index = sprVenusCarFix
		nexthurt = current_frame + 5
    }
	
    instance_destroy(id, 0)
}