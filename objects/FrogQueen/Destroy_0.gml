repeat (2) scrDrop(200, 0)

with (Player) {
    if (scrPlayerCountGoldenWeapons(id)) {
		scrWeaponPickupCreate(other.x, other.y, wep_frog_pistol, true)
		break
    }
}

event_inherited()

with instance_create(x, y, FrogQueenDeath) {
    image_xscale = other.right
	hitid = other.hitid
}

with (MusCont) alarm[1] = 1