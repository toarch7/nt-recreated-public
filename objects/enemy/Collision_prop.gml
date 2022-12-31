motion_add(point_direction(other.x, other.y, x, y), 0.5)

if other.team != team and other.hp > 0 and size > other.size and meleedamage > 0 {
    with other {
        hp -= other.meleedamage
        sprite_index = spr_hurt
        image_index = 0
    }
}