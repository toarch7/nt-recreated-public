if GameCont.area == 0 {
    instance_destroy(id, 0);
    exit
}

friction = 0.4

team = 0
size = 2

max_hp = 4

spr_idle = sprRadChest
spr_hurt = sprRadChestHurt
spr_dead = sprRadChestCorpse

event_inherited()
image_speed = 0

snd_hurt = sndHitMetal

hp = max_hp
raddrop = 25