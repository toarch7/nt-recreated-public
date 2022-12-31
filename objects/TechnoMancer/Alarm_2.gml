if (instance_exists(Corpse) && instance_exists(Player)) {
    dir = instance_nearest(x, y, Player)
    crp = instance_nearest((((x + lengthdir_x(80, point_direction(dir.x, dir.y, x, y))) + random(80)) - 40), (((y + lengthdir_y(80, point_direction(dir.x, dir.y, x, y))) + random(80)) - 40), Corpse)
    if (collision_line(x, y, crp.x, crp.y, Wall, 0, 0) < 0) {
        with(crp)
        instance_create(x, y, NecroReviveArea)
        snd_play_hit_big(sndNecromancerRevive, 0.2)
    }
    crp = instance_nearest((((x + lengthdir_x(80, (point_direction(dir.x, dir.y, x, y) + 80))) + random(80)) - 40), (((y + lengthdir_y(80, (point_direction(dir.x, dir.y, x, y) + 80))) + random(80)) - 40), Corpse)
    if (collision_line(x, y, crp.x, crp.y, Wall, 0, 0) < 0) {
        with(crp)
        instance_create(x, y, NecroReviveArea)
        snd_play_hit_big(sndNecromancerRevive, 0.2)
    }
    crp = instance_nearest((((x + lengthdir_x(80, (point_direction(dir.x, dir.y, x, y) - 80))) + random(80)) - 40), (((y + lengthdir_y(80, (point_direction(dir.x, dir.y, x, y) - 80))) + random(80)) - 40), Corpse)
    if (collision_line(x, y, crp.x, crp.y, Wall, 0, 0) < 0) {
        with(crp)
        instance_create(x, y, NecroReviveArea)
        snd_play_hit_big(sndNecromancerRevive, 0.2)
    }
}