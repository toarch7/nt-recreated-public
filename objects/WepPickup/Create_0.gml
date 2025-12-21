name = "SCREWDRIVER"
sprite_index = sprScrewDriver
wep = wep_screwdriver
type = Ammo.None
ammo = false
creator = noone
curse = false
team = 2

// parts of `cuz_fun`
autopick = false
slowreturn = false

rotspeed = random_range(0.7, 1) * choose(1, -1)

image_angle = random_angle
image_speed = 0
friction = 0.4

motion_add(random_angle, 0.5 + random(1))