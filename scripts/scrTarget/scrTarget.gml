function scrTarget() {
    target = noone

    if instance_exists(Player) {
        target = instance_nearest(x, y, Player)
    }
}