max_hp = 230

if GameCont.loops
	max_hp = 50

spr_idle = sprBigGenerator
spr_hurt = sprBigGeneratorHurt
spr_dead = sprBigGeneratorDead

size = 1

event_inherited()

snd_hurt = sndHitRock

team = 1
raddrop = 35

friction = 1000