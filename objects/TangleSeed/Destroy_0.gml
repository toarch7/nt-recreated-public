if instance_exists(Player) && Player.race == 5 && ultra_get(1) {
    var rand = irandom(90)
    for (var i = rand; i < 360 + rand; i += 72) {
        with instance_create(x, y, Tangle) {
            move_contact_solid(i, 26 + irandom(4))
        }
    }
}