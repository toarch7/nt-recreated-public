if lockstep_stop
	exit

if enemy_test && instance_exists(GameCont) {
	if instance_exists(enemy) {
		var fine = false;
		
		if GameCont.loops {
			enemy_number += instance_number(enemy) + instance_number(MeleeFake)
			enemy_count ++
			
			fine = true
		}
		
		room_speed = 120
	
		GameCont.area = 1
		GameCont.subarea = 0
		GameCont.hard = 16
		GameCont.loops = 1
		
		global.seed = randomize()
		GameCont.seed = global.seed
		
		with instance_create(Player.x, Player.y, Portal) {
			sprite_index = sprPortalDisappear
			event_perform(ev_other, ev_animation_end)
		}
		
		GameCont.rads = 0
		
		var types = {}
		
		with enemy {
			var n = object_get_name(object_index)
			
			if types[$ n] == undefined
				types[$ n] = 0
			
			types[$ n] ++
		}
		
		if types[$ "MeleeBandit"] != undefined
			types[$ "MeleeBandit"] += instance_number(MeleeFake)
		
		if fine {
			var names = variable_struct_get_names(types);
	
			for(var i = 0; i < array_length(names); i ++) {
				var name = names[i];
			
				var c = variable_struct_get(enemy_species, name),
					a = variable_struct_get(types, name)
			
				if c == undefined c = 0
				if a == undefined a = 0
			
				variable_struct_set(enemy_species, name, c + a)
			}
		
			names = variable_struct_get_names(enemy_species);
		
			for(var i = 0; i < array_length(names); i ++) {
				print(names[i] + ": " + string(variable_struct_get(enemy_species, names[i]) / enemy_count))
			}
			
			print("#" + string(enemy_count), " Average: ", enemy_number / enemy_count)
		}
	}
}

if key_check("console", keystate_press) or open {
	
	if global.console_active or UberCont.opt_console
		global.console_active = !global.console_active

    event_user(0)

    keyboard_string = ""

    open = false
}

if keyboard_check_pressed(vk_escape)
or (os_type == os_android && keyboard_check_pressed(vk_backspace))
or (keyboard_string == "" && keyboard_check_pressed(vk_enter))
{
    global.console_active = false
    event_user(0)
}

if !UberCont.opt_console
 or UberCont.daily_run
 or UberCont.weekly_run
 or UberCont.continued_run
	exit

if bound_command != "" {
    if keyboard_check_pressed(ord("P")) {
        handle_console_command(bound_command)
    }

    if mouse_check_button_pressed(mb_right) {
        bound_command = ""
        print("Bind removed.")
    }
}

if (flags & 2) == 2 && instance_exists(GenCont) {
    var iter = 0

    do {
        with FloorMaker
			event_perform(ev_step, 0)

        iter ++

        if iter >= 100
			break
    } until instance_number(Floor) >= GenCont.goal
}

if !global.console_active exit

if array_length(history) {
    if keyboard_check_pressed(vk_up) {
        historypos--

        if historypos < 0 {
            historypos = array_length(history) - 1
        }

        keyboard_string = history[historypos]
    }
	else if keyboard_check_pressed(vk_down) {
        historypos++

        if historypos >= array_length(history) {
            historypos = 0
        }

        keyboard_string = history[historypos]
    }
}

if keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) {
    keyboard_string += clipboard_get_text()
}

if keyboard_check_pressed(vk_enter) && string_length(keyboard_string) {
    if laststr != keyboard_string {
        array_push(history, keyboard_string)
        laststr = keyboard_string
    }

    if handle_console_command(keyboard_string) {
        printc(keyboard_string, c_gray)
    }
	else printc(keyboard_string, c_white - 1)

    keyboard_string = ""

    historypos = -1
}