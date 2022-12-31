if other.ammo[other.wep_type[other.wep]] = other.typ_amax[other.wep_type[other.wep]] or other.ammo[other.wep_type[other.bwep]] = other.typ_amax[other.wep_type[other.bwep]]
type = choose(1, 2, 3, 4, 5)
else if other.bwep != 0 type = choose(other.wep_type[other.wep], other.wep_type[other.bwep])
else type = other.wep_type[other.wep]

if type = 0 type = choose(1, 2, 3, 4, 5)

extra = 0
//RUSH CROWN
if GameCont.crown = 4 extra = 1

other.ammo[type] += round(other.typ_ammo[type] * 1.5) + extra

if other.ammo[type] > other.typ_amax[type] other.ammo[type] = other.typ_amax[type]

dir = instance_create(x, y, PopupText)
dir.mytext = "+" + string(round(other.typ_ammo[type] * 1.5) + extra) + " " + loc(loc(other.typ_name[type]))
if other.ammo[type] = other.typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(other.typ_name[type]))

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