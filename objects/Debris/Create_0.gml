var area;

if !instance_exists(Menu) && instance_exists(GameCont) {
	area = GameCont.area
}
else area = 0

friction = 0.2
sprite_index = asset_get_index("sprDebris" + string(area))
image_speed = 0
image_index = random(4)
image_angle = random_angle
size = 1
motion_add(random_angle, 6 + random(2))
alarm[0] = 200 + random(90)
time = 10

if speed > 0 alarm[1] = random(10) / speed + 1