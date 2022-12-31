with Smoke instance_destroy()
with RadChest instance_destroy(id, 0)
with WeaponChest instance_destroy(id, 0)
with AmmoChest instance_destroy(id, 0)

with Floor {
    instance_create(x - 32, y, Top)
    instance_create(x + 32, y, Top)
    instance_create(x, y + 32, Top)
    instance_create(x, y - 32, Top)
    instance_create(x - 32, y + 32, Top)
    instance_create(x + 32, y + 32, Top)
    instance_create(x - 32, y - 32, Top)
    instance_create(x + 32, y - 32, Top)
}