if lockstep_stop
	exit

GameCont.crownpoints ++

if !instance_exists(CrownObject) {
    with instance_create(x, y, CrownObject) {
        is_new = true
    }
}

with Player {
    if (scrPlayerUncurse(id)) repeat(10) {
        instance_create(x + orandom(8), orandom(8), Curse)
    }
}

if (!instance_exists(VaultStatue)) {
    with (instance_create(x, y, Portal)) type = 3
}

snd_play(other.snd_crwn)

with (VaultStatue) hp = 0

instance_destroy()