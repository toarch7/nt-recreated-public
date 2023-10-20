fishx = room_width / 2
fishy = room_height / 2

bossfight = instance_exists(Nothing2) or instance_exists(Nothing2Appear)

image_angle = random_angle
active = 0

letterbox = 0

type = 1
//1 = normal 2 = proto 3 = idpd 4= venuz
time = 0

area = 0

if instance_exists(GameCont)
	area = GameCont.area

if instance_exists(GameCont) {
    if GameCont.area == 100
		type = 2

    if GameCont.area == 106
		type = 3

    if GameCont.area == 103 or GameCont.area == 107
		type = 4
}


repeat 150 {
    event_perform(ev_step, 0)

    with Spiral
		event_perform(ev_step, 0)

    with SpiralDebris
		event_perform(ev_step, 0)

    with SpiralStar
		event_perform(ev_step, 0)
}

active = 1

snd_play_ambient(sndPortalLoop, true)