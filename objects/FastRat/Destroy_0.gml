givekill = 0
event_inherited()
scrDrop(20, 0)

with instance_create(x, y, AcidStreak) {
    motion_add(other.direction, 8)
    image_angle = direction
}