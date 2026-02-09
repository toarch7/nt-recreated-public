#macro CONSOLE_LOG_CAPACITY 40

function print() {
	static _buffer = buffer_create(1024, buffer_grow, 1)
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	
	//
	var _index = 1
	buffer_write(_buffer, buffer_text, string(argument[0]))
	repeat (argument_count - 1) {
		buffer_write(_buffer, buffer_text, " ")
		buffer_write(_buffer, buffer_text, string(argument[_index ++]))
	}
	
    buffer_write(_buffer, buffer_u8, 0)
	
	var _str = buffer_peek(_buffer, 0, buffer_text)
	
	show_debug_message(_str)
	scr_log_push(_str)
}

function scr_log_push(_message, _color = c_white) {
	if string_count("\n", _message) > 0 {
		var list = string_split(_message, "\n", true),
			count = array_length(list)
		
		repeat count
			scr_log_push(list[-- count], _color)
		
		exit
	}
	
	if array_length(global.log_output) >= CONSOLE_LOG_CAPACITY {
		array_delete(global.log_output, CONSOLE_LOG_CAPACITY - 1, 1)
		array_delete(global.log_color, CONSOLE_LOG_CAPACITY - 1, 1)
	}
	
	array_insert(global.log_output, 0, _message)
	array_insert(global.log_color, 0, _color)
}

function scr_debug_print_stacktrace(_message = undefined, _start = 0) {
	var _trace = debug_get_callstack(99)
	array_pop(_trace)
	array_reverse_ext(_trace)
	
	var _string = string_join_ext("\n|- ", _trace, _start)
	if is_string(_message) {
		show_debug_message("|---" + string(_message) + "\n|- " + _string)
	}
	else {
		show_debug_message("\n|- " + string(_string))
	}
}