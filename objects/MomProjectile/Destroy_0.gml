instance_create(x, y, PortalClear)

repeat 25 {
    with instance_create(x, y, ToxicGas) {
        team = other.team
        hit_id = other.hit_id
    }
}