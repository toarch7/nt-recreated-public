enum SpiralType {
	Normal,
	Proto,
	IDPD,
	Venuz
}

fishx = view_width div 2
fishy = view_height div 2

image_angle = random_angle

bossfight = instance_exists(Nothing2) || instance_exists(Nothing2Appear) || instance_exists(NothingSpiral)

type = SpiralType.Normal

active = true
area = area_campfire
time = 0

if instance_exists(GameCont) {
	area = GameCont.area
	
    if area == area_vault {
		type = SpiralType.Proto
	}
    else if area == area_hq {
		type = SpiralType.IDPD
	}
    else if (area == area_mansion || area == area_crib) {
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


if (!instance_exists(NothingSpiral)) scrLetterbox(true)