alarm[0] = 25
curse = 0

with YungCuz {
    if (!chestsound) {
		snd_play_hit(sndCuzOpen, 0.1)
		chestsound = true
	}
}

instance_create(x - 32, y - 32, PortalClear)
instance_create(x + 32, y + 32, PortalClear)
instance_create(x + 32, y - 32, PortalClear)
instance_create(x - 32, y + 32, PortalClear)