var _bwp = other.bwep

if other.race == 13 other.bwep = 7

if other.ammo[other.wep_type[other.wep]] >= other.typ_amax[other.wep_type[other.wep]] or other.ammo[other.wep_type[other.bwep]] >= other.typ_amax[other.wep_type[other.bwep]]
type = choose(1, 2, 3, 4, 5)
else if other.bwep != 0 type = choose(other.wep_type[other.wep], other.wep_type[other.bwep])
else type = other.wep_type[other.wep]

if other.race == 13 other.bwep = _bwp

if type = 0 type = choose(1, 2, 3, 4, 5)

extra = 0
//RUSH CROWN
if GameCont.crown = 4 extra = 1

other.ammo[type] += other.typ_ammo[type] + extra

if other.ammo[type] > other.typ_amax[type] other.ammo[type] = other.typ_amax[type]


dir = instance_create(x, y, PopupText)
dir.mytext = "+" + string(other.typ_ammo[type] + extra) + " " + string(loc(other.typ_name[type]))
if other.ammo[type] = other.typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(other.typ_name[type]))

snd_play(sndAmmoPickup)
instance_destroy()

instance_create(x, y, SmallChestPickup)

if GameCont.coopultra == 1 {
    var plr = other.id

    with Player
    if id != plr {
        ammo[other.type] += typ_ammo[other.type]

        if ammo[other.type] > typ_amax[other.type] ammo[other.type] = typ_amax[other.type]
    }
}