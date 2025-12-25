max_hp = 24
size = 1

if (!instance_exists(Floor) || instance_nearest(x - 16, y - 16, Floor).styleb == 0) {
	spr_idle = sprSodaMachine
	spr_hurt = sprSodaMachineHurt
	spr_dead = sprSodaMachineDead
}
else {
    spr_idle = sprNewsStand
    spr_hurt = sprNewsStandHurt
    spr_dead = sprNewsStandDead
}


event_inherited()
image_xscale = 1

snd_hurt = sndHitMetal
snd_dead = sndSodaMachineBreak