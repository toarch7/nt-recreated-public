if instance_exists(Player) && sprite_index != sprProtoChest {
    if distance_to_object(Player) > 32 {
        sprite_index = sprProtoChest
        wep = other.wep

        with other {
            instance_destroy()
        }
    }
}