raddrop = 22
max_hp = 45
meleedamage = 20
size = 2
hit_id = sprLaserCrystalIdle
spr_idle = sprLaserCrystalIdle
spr_walk = sprLaserCrystalIdle
spr_hurt = sprLaserCrystalHurt
spr_dead = sprLaserCrystalDead
event_inherited()
spr_fire = sprLaserCrystalFire
snd_hurt = sndLaserCrystalHit
snd_dead = sndLaserCrystalDeath
ammo = 4
gunangle = random_angle
alarm[1] = (50 + random(90))
explode = 0
var rand = 25
/*if (GameCont.crown == 7)
    rand *= 0.7
if ((random(rand) < (1 + (GameCont.loops * 5))) && (GameCont.subarea > 1))
{
    instance_destroy()
    instance_create(x, y, LightningCrystal)
}*/

spr_shadow_y = 4

/* */
/*  */