if bounce {
    bounce = 0
    move_bounce_solid(00)
    instance_create(x, y, Dust)
    exit
}

instance_destroy()
instance_create(x, y, Dust)
snd_play_hit(sndHitWall, .2)