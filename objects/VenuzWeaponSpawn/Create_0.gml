alarm[0] = 25
curse = 0

with YungCuz {
    if chestsound == 0 snd_play_hit(sndCuzOpen, 0.1) chestsound = 1
}

instance_create(x - 32, y - 32, PortalClear)
instance_create(x + 32, y + 32, PortalClear)
instance_create(x + 32, y - 32, PortalClear)
instance_create(x - 32, y + 32, PortalClear)