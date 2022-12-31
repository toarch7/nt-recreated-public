alarm[0] = 30 - irandom(10)

walk += 10
direction += choose(90, - 90)

target = instance_nearest(x, y, enemy)