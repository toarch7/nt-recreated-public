#macro CONSOLE_MAX_CAPACITY 40

function scr_log_push(msg, color) {
	if string_count("\n", msg) > 0 {
		var list = string_split(msg, "\n", true),
			count = array_length(list)
		
		repeat count
			scr_log_push(list[-- count], color)
		
		exit
	}
	
	array_insert(global.log_output, 0, msg)
	array_insert(global.log_color, 0, color)
	
	if array_length(global.log_output) >= CONSOLE_MAX_CAPACITY {
		array_delete(global.log_output, CONSOLE_MAX_CAPACITY, 1)
		array_delete(global.log_color, CONSOLE_MAX_CAPACITY, 1)
	}
}

function print() {
    var str = string(argument[0])

    for (var __arg = 1; __arg < argument_count; __arg++) {
        str += " " + string(argument[__arg])
    }

    scr_log_push(str, c_white)

    show_debug_message(str)
}

function printc(text, col) {
	scr_log_push(text, col)
}