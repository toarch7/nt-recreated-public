max_hp = 5
size = 1

if instance_nearest(x - 16, y - 16, Floor).styleb = 0 {
    spr_idle = sprHydrant
    spr_hurt = sprHydrantHurt
    spr_dead = sprHydrantDead
} else {
    spr_idle = sprIcicle
    spr_hurt = sprIcicleHurt
    spr_dead = sprIcicleDead
}


event_inherited()


snd_hurt = sndHitMetal
if spr_idle = sprIcicle snd_hurt = sndHitRock