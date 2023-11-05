function scrStrongSpiritRefill() {
	with instance_create(x, y, StrongSpiritRefill) {
        depth = other.depth - 1
        creator = other.id
    }

    spirit = 1

    snd_play(sndStrongSpiritRecover)
    spirit_index = 0
    can_spirit = 0
}