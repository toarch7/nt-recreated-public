#macro ATTACK_BUTTON_DEADZONE 0.33

x = view_width + (global.view_width_max - view_width) / 2 - 64
y = view_height - 64

event_inherited()

rad = 32

dis = 0
dir = 0

clicked = 0

dis = 0
vdis = 0 //dynamic view

assist = UberCont.opt_assist
aim_target = noone

crosshair = save_get_val("visual", "crosshair", 0)

pause = 0

followmove = 1

image_angle = 0

button_name = "SHOOT JOYSTICK"

if UberCont.opt_splitfire
	button_name = "AIM JOYSTICK"

hold = 0

alarm[1] = 1

wep_spr = mskNone