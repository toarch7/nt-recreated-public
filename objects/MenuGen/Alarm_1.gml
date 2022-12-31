with Floor {
    if !position_meeting(x - 32, y, Floor) instance_create(x - 32, y, Floor)
    if !position_meeting(x + 32, y, Floor) instance_create(x + 32, y, Floor)
    if !position_meeting(x, y - 32, Floor) instance_create(x, y - 32, Floor)
    if !position_meeting(x, y + 32, Floor) instance_create(x, y + 32, Floor)
}

with Floor {
    if !position_meeting(x - 16, y - 16, Floor) instance_create(x - 16, y - 16, Wall)
    if !position_meeting(x, y - 16, Floor) instance_create(x, y - 16, Wall)
    if !position_meeting(x + 16, y - 16, Floor) instance_create(x + 16, y - 16, Wall)
    if !position_meeting(x + 32, y - 16, Floor) instance_create(x + 32, y - 16, Wall)
    if !position_meeting(x + 32, y, Floor) instance_create(x + 32, y, Wall)
    if !position_meeting(x + 32, y + 16, Floor) instance_create(x + 32, y + 16, Wall)
    if !position_meeting(x - 16, y, Floor) instance_create(x - 16, y, Wall)
    if !position_meeting(x - 16, y + 16, Floor) instance_create(x - 16, y + 16, Wall)
    if !position_meeting(x - 16, y + 32, Floor) instance_create(x - 16, y + 32, Wall)
    if !position_meeting(x, y + 32, Floor) instance_create(x, y + 32, Wall)
    if !position_meeting(x + 16, y + 32, Floor) instance_create(x + 16, y + 32, Wall)
    if !position_meeting(x + 32, y + 32, Floor) instance_create(x + 32, y + 32, Wall)
}

with RadChest
instance_destroy()
with WeaponChest
instance_destroy()
with AmmoChest
instance_destroy()
with BigWeaponChest
instance_destroy()
with ChestOpen
instance_destroy()

with Vlambeer {
    mode = 1
    alarm[0] = 30
}

alarm[2] = 30