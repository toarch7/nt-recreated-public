speed = 0
event_inherited()

repeat (3) {
	instance_create(x, y, Explosion)
}

if scrCrownCheck(crwn_guns) {
	scrDrop(0, 60)
}
else {
	repeat (2) scrDrop(100, 0)
}

repeat (6) {
    with instance_create(x, y + orandom(16), GroundFlame) {
        move_contact_solid(random_angle, 8 + random(12))
    }
}

var _ang = random_angle;

repeat (10) {
	scrFX(x, y, Dust, _ang, 3)
	_ang += 36
	
	scrFX(random_range(bbox_left, bbox_right),
		random_range(bbox_top, bbox_bottom), PortalL, random_angle, 3)
}

scrRadDrop(x, y, raddrop)

if !GameCont.loops && instance_number(BigGenerator) <= 1 {
    snd_play(sndNothingGenerators)
    with (Nothing) hp = round(hp / 2)
}