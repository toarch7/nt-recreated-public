typ = 0
trn = ((random(5) + 5) * choose(1, - 1))

if instance_exists(target) {
	direction = point_direction(x, y, target.x, target.y)
}
else direction = random(360)

bounces = 0
image_speed = 0.4

snd_play_hit_big(sndLilHunterBreak, 0.2)

speed = 2
instance_create(x, y, PortalClear)