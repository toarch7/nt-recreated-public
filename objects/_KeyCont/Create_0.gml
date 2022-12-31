//this beauty handles keyboard & gamepad input.. work in progress
players = 1

//-1 = false, 0 = gamepad 0, 1 = gamepad 1
if UberCont.opt_gamepad = 1 gamepad[0] = 0
else gamepad[0] = -1

scrKeyContInit()