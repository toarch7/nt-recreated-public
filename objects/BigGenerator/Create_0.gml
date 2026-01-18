max_hp = 230

if GameCont.loops
	max_hp = 50

spr_idle = sprBigGenerator
spr_hurt = sprBigGeneratorHurt
spr_dead = sprBigGeneratorDead

event_inherited()

size = 5

snd_hurt = sndBigGeneratorHurt
snd_dead = sndBigGeneratorBreak

team = 1
raddrop = 35

friction = 1000

hitid = HitId.Generator