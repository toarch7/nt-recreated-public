sit = 0
spr_sit = sprMutant1Sit
spr_gosit = sprMutant1GoSit

with Player {
    if is_me {
        other.spr_sit = spr_sit
        other.spr_gosit = spr_gosit
    }
}

weapon = mskNone
bweapon = mskNone

volume_control_command = 0

debug = 0

force_sit = 0

if GameCont.area == 106 {
    alarm[3] = 560
}