friction = 0.2
image_angle = random_angle
depth = 0

blink = 30

alarm[0] = (150 + random(30)) / ((4 + GameCont.loops) / 4)

if (scrCrownCheck(crwn_haste)) alarm[0] /= 3

image_index = random(7)
image_speed = 0

var _distance = scr_ultra_get(Race.Frog, UltraSkill.Distance)

if (_distance != 0) {
	var _is_me = (scrPlayerCountRace(Race.Frog, true) != 0)
	
	if (object_index == BigRad) {
		repeat (4 * _distance) {
			with (instance_create(x, y, ToxicGas)) {
				if (_is_me) scrFrogGasStat()
			}
		}
		
		alarm[0] += 40
	}
	else if (random(1) < 0.33) {
		repeat (scr_ultra_get(Race.Frog, UltraSkill.Distance)) {
			with (instance_create(x, y, ToxicGas)) {
				if (_is_me) scrFrogGasStat()
			}
		}
	}
}