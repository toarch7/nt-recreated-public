with instance_create(x, y, ChestOpen)
sprite_index = sprHealthChestOpen

instance_create(x, y, FXChestOpen)

if skill_get(9) {
    snd_play(sndHealthChestBig)
} else snd_play(sndHealthChest)