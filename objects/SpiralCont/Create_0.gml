enum SpiralType {
	Normal,
	Proto,
	IDPD,
	Venuz
}

fishx = view_width div 2
fishy = view_height div 2

image_angle = random_angle

bossfight = instance_exists(Nothing2) || instance_exists(Nothing2Appear)
type = SpiralType.Normal

letterbox = 0
active = 0
time = 0
area = 0


if instance_exists(GameCont) {
	area = GameCont.area
}

if instance_exists(GameCont) {
    if area == Area.Vault {
		type = SpiralType.Proto
	}
    else if area == Area.HQ {
		type = SpiralType.IDPD
	}
    else if (area == Area.VenusMansion || area == Area.YVCrib) {
		type = SpiralType.Venuz
	}
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

snd_play_ambience(sndPortalLoop, true)

active = true