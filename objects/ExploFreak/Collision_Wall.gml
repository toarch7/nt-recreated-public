event_inherited()

if instance_exists(Player) {
    if point_distance(x, y, Player.x, Player.y) < 96 {
        snd_play(snd_mele)
        instance_destroy()
    }
}