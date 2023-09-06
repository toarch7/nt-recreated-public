if lockstep_stop
	exit

GameCont.crownpoints += 1

if !instance_exists(Crown) {
    with instance_create(x, y, Crown) {
        is_new = 1
    }
}

with Player {
    if curse or bcurse {
        repeat(10)
        instance_create(x + random_range(-8, 8), y + random_range(-8, 8), Curse)
    }

    if curse or bcurse snd_play(sndUncurse)

    curse = 0
    bcurse = 0
}

if instance_exists(VaultStatue) {
    with VaultStatue {
        hp = 0
    }
} else {
    with instance_create(x, y, Portal)
		type = 3
}

snd_play(other.snd_crwn)

with VaultStatue {
    hp = 0
}

instance_destroy()