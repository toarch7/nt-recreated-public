speed = 0
event_inherited()
scrDrop(50, 0)
scrDrop(50, 0)
with instance_create(x, y, SnowTankExplode) {
    size = other.size
    mask_index = other.mask_index
    sprite_index = sprGoldTankExplode
    hitid = other.hitid
    right = other.right
    image_xscale = other.right
}