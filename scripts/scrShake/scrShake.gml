function weapon_post(direction, shift, shake, recoil) {
    BackCont.viewx2 += lengthdir_x(shift, direction + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(shift, direction + 180) * UberCont.opt_shake
    BackCont.shake += shake * UberCont.opt_shake
    wkick = recoil
}