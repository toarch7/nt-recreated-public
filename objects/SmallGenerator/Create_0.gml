max_hp = 40
size = 1

spr_idle = sprSmallGenerator
spr_hurt = sprSmallGeneratorHurt
spr_dead = sprSmallGeneratorDead

event_inherited()

snd_hurt = sndHitMetal
snd_dead = sndGeneratorBreak

raddrop = 5

image_xscale = choose(1, -1)

hitid = HitId.SmallGenerator