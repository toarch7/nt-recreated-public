if instance_exists(Player) && sprite_index != sprProtoChest {
    if point_distance(x, y, Player.x, Player.y) > 32 {
        sprite_index = sprProtoChest
        wep = other.wep

        with other {
            instance_destroy()
        }
    }
}