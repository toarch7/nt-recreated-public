speed = 0
event_inherited()
scrDrop(50, 0)
scrDrop(50, 0)
with instance_create(x, y, SnowTankExplode) {
    size = other.size
    mask_index = other.mask_index
    sprite_index = sprGoldTankExplode
    hit_id = other.hit_id
    right = other.right
    image_xscale = other.right
}