if other.ammo[wep_type[other.wep]] = typ_amax[wep_type[other.wep]] or other.ammo[wep_type[other.bwep]] = typ_amax[wep_type[other.bwep]]
type = choose(1, 2, 3, 4, 5)
else if other.bwep != 0 type = choose(wep_type[other.wep], wep_type[other.bwep])
else type = wep_type[other.wep]

if type = 0 type = choose(1, 2, 3, 4, 5)

extra = 0
//RUSH CROWN
if GameCont.crown = 4 extra = 1

other.ammo[type] += round(typ_ammo[type] * 1.5) + extra

if other.ammo[type] > typ_amax[type] other.ammo[type] = typ_amax[type]

dir = instance_create(x, y, PopupText)
dir.mytext = "+" + string(round(typ_ammo[type] * 1.5) + extra) + " " + loc(loc(typ_name[type]))
if other.ammo[type] = typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(typ_name[type]))

snd_play(sndAmmoPickup)
instance_destroy()

instance_create(x, y, SmallChestPickup)

if GameCont.coopultra == 1 {
    var plr = other.id

    with Player
    if id != plr {
        ammo[other.type] += round(typ_ammo[other.type] * 1.5)

        if ammo[other.type] > typ_amax[other.type] ammo[other.type] = typ_amax[other.type]
    }
}