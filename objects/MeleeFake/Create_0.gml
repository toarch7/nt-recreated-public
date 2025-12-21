image_index = random(image_number)

raddrop = 8
max_hp = 8
meleedamage = 1
size = 1
target = noone
spr_idle = sprite_index
spr_walk = sprite_index
spr_hurt = sprMeleeHurt
spr_dead = sprMeleeDead
hitid = HitId.Assassin

event_inherited()

snd_hurt = sndAssassinHit
snd_dead = sndAssassinDie

image_speed = 0
sprite_index = spr_idle

//behavior
walk = 0
gunangle = random_angle
wepangle = choose(-140, 140)
wepflip = 1

friction = 0.4
right = choose(1, -1)

scrEnemyApplyCreationEffects()

team = 1

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie

__get_spawn_enemy_object = function() {
	if object_index == JungleAssassinHide {
		return JungleAssassin
	}
	
	return MeleeBandit
}