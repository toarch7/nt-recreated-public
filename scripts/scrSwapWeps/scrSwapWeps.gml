function scrSwapWeps() {
    //SWAP DA WEPS
    twep = wep
    tcurse = curse
    treload = reload
    twkick = wkick
    twepflip = wepflip
    twepangle = wepangle
    tcan_shoot = can_shoot

    wep = bwep
    curse = bcurse
    reload = breload
    wkick = bwkick
    wepflip = bwepflip
    wepangle = bwepangle
    can_shoot = bcan_shoot

    bwkick = twkick
    bcurse = tcurse
    bcan_shoot = tcan_shoot
    bwepflip = twepflip
    bwepangle = twepangle
    breload = treload
    bwep = twep
    clicked = 0

    if reload > 0 can_shoot = 0
    else can_shoot = 1

    if wep_type[wep] != 0 and wep != 24 and wep != 36 and wep != 53 wepangle = 0
    else if wepangle = 0 wepangle = choose(120, - 120)

    drawempty = 30

    if instance_exists(TutorialCont) && TutorialCont.pos == 2 && !TutorialCont.doin {
        TutorialCont.alarm[0] = 30
        TutorialCont.doin = 1
    }



}