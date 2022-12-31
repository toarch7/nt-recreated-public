if (instance_number(enemy) < 10) {
    instance_destroy()
    exit
}
if instance_exists(Player) {
    if ((point_distance(x, y, Player.x, Player.y) < 120) && (random(90) < 1)) {
        with(BecomeTurret) {
            if (collision_line(x, y, Player.x, Player.y, Wall, 1, 0) < 0) {
                instance_create(x, y, Turret)
                instance_destroy()
            }
        }
    }
}