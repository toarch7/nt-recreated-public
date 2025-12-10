snd_stop(snd)
snd_play_hit_big(sndLightningCannonEnd, 0.3)

instance_create(x, y, PortalClear)

repeat (9) scrLightningCreate(x, y, random_angle, irandom_range(10, 20))
