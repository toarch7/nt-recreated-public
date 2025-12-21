if lockstep_stop
	exit

if scrChestOpened() exit

with (instance_nearest(x, y, Player)) {
	if (race != Race.Rogue) {
		scrRadDrop(other.x, other.y, 25)
		break
	}
	
	with (instance_create(x, y, RogueAmmo)) {
		event_perform(ev_collision, Player)
	}
}

snd_play(sndRogueCanister)

instance_destroy()