scrTarget()
alarm[1] = 20 + random(20)
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if rage = 0 rage = 1 direction = target_direction + random(60) - 30
    } else {
        if hp < max_hp and random(2) < 1 {
            image_index = 0
            snd_play(sndBigMaggotBurrow)
            instance_change(BigMaggotBurrow, false)
            speed = 0
            alarm[0] = 30
        }
        rage = 0
        motion_add(random(360), 1)
    }
} else {
    rage = 0
    motion_add(random(360), 1)
}