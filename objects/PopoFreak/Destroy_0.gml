scrDrop(60, 0)
event_inherited()

if instance_exists(Player) {
    with Player
    if is_me && race == 12 {
        UberCont.ctot_uniq[12] += 1
    }
}

if random(4) < 1 {
    repeat 3 {
        with instance_create(x, y, PopoNade) {
            hit_id = other.hit_id
            motion_add(other.direction, 4)
            motion_add(random(360), 4)
            image_angle = direction
            team = other.team
        }
    }
}

with WantVan
canspawn = 1

instance_create(x, y, WantRevivePopoFreak)