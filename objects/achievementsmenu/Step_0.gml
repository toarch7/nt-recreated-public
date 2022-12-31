if mouse_check_button_pressed(mb_left) {
    click = 1
    mousex = mouse_x
    mousey = mouse_y
    speed = 0
}

if UberCont.opt_gamepad {
    v = gamepad_button_check(0, gpad.padd) - gamepad_button_check(0, gpad.padu)

    speed = v * 8
}

if mouse_wheel_up() speed = 16
if mouse_wheel_down() speed = -16

/*
if click {
    hold_time ++
    
    if mouse_check_button_released(mb_left) {
        motion_add(
            point_direction(mouse_x, mouse_y, mousex, mousey), 
            point_distance(mousex, mousey, mouse_x, mouse_y) / hold_time
        )
        
        click = 0
        hold_time = 0
    }
}*/

ypos += lengthdir_y(speed, direction)
ypos = clamp(ypos, 0, max_height)

if ypos <= 0 or ypos >= max_height {
    speed = 0
}

view_xview = 0
view_yview = 0