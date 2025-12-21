if scrPlayerCountRace(Race.Rogue) {
	instance_create(x, y, RogueAmmo)
}
else {
	scrRadDrop(x, y, 25)
}

instance_destroy()