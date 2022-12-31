function scrEmpty() {
    clicked = 0
    snd_play(sndEmpty)
    var dir = instance_create(x, y, PopupText)
    dir.mytext = loc("EMPTY")

    if ammo[wep_type[wep]] > 0 {
        dir.mytext = loc_sfmt("NOT ENOUGH %", loc(typ_name[wep_type[wep]]))
    } else if (wep_rads[@wep] > 0 && GameCont.rad < wep_rads[@wep]) {
        dir.mytext = loc("NOT ENOUGH RADS")
    }

    clicked = 0
    wkick = -2
}