if scr_projectile_generic_flame_hit() {
    x = (x + other.x) * 0.5 + orandom(3)
    y = (y + other.y) * 0.5 + orandom(3)
    speed *= 0.8
}