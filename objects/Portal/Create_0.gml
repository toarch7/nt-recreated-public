image_speed = 0.4

endgame = 100

if GameCont.area != 101 {
    snd_play(sndPortalOpen)
}
else snd_play(sndOasisPortal)

if instance_exists(Player) {
    with projectile {
        if team != 2 {
			instance_destroy(id, 0)
		}
	}
}

instance_create(x, y, PortalClear)
instance_create(x, y, PortalShock)

with Player {
	if race != 12
		continue
	
    repeat 2 {
        instance_create(other.x, other.y, IDPDSpawn)
    }
	
    GameCont.popolevel -= 1.5
}

close = 0