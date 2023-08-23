if scrChestOpened()
	exit

var p = instance_nearest(x, y, Player)

if !p
	exit

if p.race != 12 {
    repeat 25 {
        with instance_create(x, y, Rad)
        motion_add(random(360), random(5))
    }
}
else with p {
	with instance_create(x, y, RogueAmmo)
		event_perform(ev_collision, Player)
}

snd_play(sndRogueCanister)
instance_destroy()

