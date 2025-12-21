with (MusCont) alarm[1] = 1

if (instance_exists(Player)) scrOnPopoKill()

with (instance_create(x, y, LastDie)) {
    hitid = other.hitid
    team = other.team
}

event_inherited()