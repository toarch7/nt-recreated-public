if (hp > 0) exit

scrDrop(200, 0)

corpse = false

event_inherited()

instance_create(x, y, PortalClear)

scrOnPopoKill()

with instance_create(x, y, LilHunterDie) {
    hitid = HitId.LilHunterDie
    team = other.team
}

with MusCont alarm[1] = 1

with instance_create(x, y, Explosion)
	hitid = other.hitid

var firang = random_angle

repeat 80 {
    firang += 4.5
	
    with instance_create(x, y, TrapFire) {
        hitid = other.hitid
        sprite_index = sprFireLilHunter
        motion_add(firang, 2 + random(0.2))
        move_contact_solid(direction, 12)
        image_angle = direction
        team = other.team
    }
}

scrOnBossKill()