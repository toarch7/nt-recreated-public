with(instance_create(x, y, PopoExplosion)) {
    team = other.team
    hitid = other.hitid
}

repeat (4) {
	instance_create(x + orandom(24), y + orandom(24), BlueFlame)
}