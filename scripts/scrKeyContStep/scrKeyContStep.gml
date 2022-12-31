function scrKeyContStep() {
    p = 0 //player id

    repeat(players) {
        if gamepad[p] = -1 {
            //KEYBOARD CONTROLS FOR THIS DUDE
            //0 = nothing 1 = pressed 2 = hold = 3 = release //SO ON HOLD is both 1 and 2 AND NOT HELD IS BOTH 3 and 0

            //up
            if keyboard_check(ord("W")) or keyboard_check(vk_up) {
                if key_nort[p] = 1 key_nort[p] = 2
                else if key_nort[p] != 2 key_nort[p] = 1
            } else {
                if key_nort[p] = 3 key_nort[p] = 0
                else if key_nort[p] != 0 key_nort[p] = 3
            }

            //down
            if keyboard_check(ord("S")) or keyboard_check(vk_down) {
                if key_sout[p] = 1 key_sout[p] = 2
                else if key_sout[p] != 2 key_sout[p] = 1
            } else {
                if key_sout[p] = 3 key_sout[p] = 0
                else if key_sout[p] != 0 key_sout[p] = 3
            }

            //left
            if keyboard_check(ord("A")) or keyboard_check(vk_left) {
                if key_west[p] = 1 key_west[p] = 2
                else if key_west[p] != 2 key_west[p] = 1
            } else {
                if key_west[p] = 3 key_west[p] = 0
                else if key_west[p] != 0 key_west[p] = 3
            }

            //right
            if keyboard_check(ord("D")) or keyboard_check(vk_right) {
                if key_east[p] = 1 key_east[p] = 2
                else if key_east[p] != 2 key_east[p] = 1
            } else {
                if key_east[p] = 3 key_east[p] = 0
                else if key_east[p] != 0 key_east[p] = 3
            }


            //fire
            //if mouse_check_button(mb_left) or keyboard_check(vk_enter){
            //     if key_fire[p] = 1 key_fire[p] = 2
            //else if key_fire[p] !=2 key_fire[p] = 1}
            //else{if key_fire[p] = 3 key_fire[p] = 0
            //else if key_fire[p] !=0 key_fire[p] = 3}

            //special
            if mouse_check_button(mb_right) {
                if key_spec[p] = 1 key_spec[p] = 2
                else if key_spec[p] != 2 key_spec[p] = 1
            } else {
                if key_spec[p] = 3 key_spec[p] = 0
                else if key_spec[p] != 0 key_spec[p] = 3
            }

            //swap
            if keyboard_check(vk_space) or mouse_wheel_up() or mouse_wheel_down() or mouse_check_button(mb_middle) or keyboard_check(vk_space) or keyboard_check(ord("Q")) { //SWAP:joy_pressed(joy,3)
                if key_swap[p] = 1 key_swap[p] = 2
                else if key_swap[p] != 2 key_swap[p] = 1
            } else {
                if key_swap[p] = 3 key_swap[p] = 0
                else if key_swap[p] != 0 key_swap[p] = 3
            }

            //pick
            if keyboard_check(ord("E")) or keyboard_check(vk_shift) or keyboard_check(vk_control) { //joy_pressed(joy,2)
                if key_pick[p] = 1 key_pick[p] = 2
                else if key_pick[p] != 2 key_pick[p] = 1
            } else {
                if key_pick[p] = 3 key_pick[p] = 0
                else if key_pick[p] != 0 key_pick[p] = 3
            }

        }

        p += 1
    }



}