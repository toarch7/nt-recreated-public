friction = 0.4


repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(2))
}

depth = -3
attract = 1

snd_play_hit(sndUltraGrenadeSuck, 0.2)