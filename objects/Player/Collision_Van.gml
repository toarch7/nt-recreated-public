if lockstep_stop
	exit

if KeyCont.press_pick[p] = 1 && is_me && other.can_hq && other.drawspr = sprVanDeactivate {
    if GameCont.triedhq {
        with other
        hp = 0
    } else {
        snd_play(sndUseVan)

        if GameCont.area != 106 {
            GameCont.area = 106
            GameCont.subarea = 0
        } else {
            GameCont.area = GameCont.hqarea
            GameCont.subarea = GameCont.hqsubarea
            GameCont.triedhq = 1
        }

        with other {
            instance_destroy(self, 0)
        }

        with enemy {
            hp = 0
        }

        inframes = 5

        with instance_create(x, y, Portal) {
            type = 2
        }
    }
}