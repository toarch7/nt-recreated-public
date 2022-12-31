instance_create(x, y, CrownGuardian)

with VaultStatue {
    hp = 0
}

with CrownPickup
instance_destroy()

event_inherited()

with MusCont {
    alarm[4] = 1
}