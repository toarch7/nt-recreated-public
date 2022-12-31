drawspr = sprTechnoMancer
drawimg = 0
if instance_exists(Player) {
    if ((intro == 0) && (collision_line(x, y, Player.x, Player.y, Wall, 0, 0) < 0)) {
        alarm[3] = 2
        with(TechnoMancer)
        intro = 1
        with(MusCont)
        alarm[2] = 1
    }
}