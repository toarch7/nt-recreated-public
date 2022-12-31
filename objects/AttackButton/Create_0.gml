/*pos_x = save_get_val("controls", "JoystickAttack_x", view_width - 64)
pos_y = save_get_val("controls", "JoystickAttack_y", view_height - 64)

x = pos_x
y = pos_y

anyone_else = 0

rad = 24
max_rad = 96
collision = 0
clicked = 0
dis = 0
dir = 0

assist = KeyCont.aimassist[global.index]
_aim_target = noone

crosshair = save_get_val("visual", "crosshair", 0)

if !save_get_val("controls", "aimbot", 0) {
    instance_create(x, y, JoystickAttack)
    instance_destroy()
}

pause = 0
player = noone

with Player if is_me
player = other.id

alarm[0] = 30
horrortime = 0

image_angle = 45

button_name = "SHOOT BUTTON"
hold = 0*/