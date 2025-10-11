#macro CONSOLE_LOG_CAPACITY 40

function print() {
	static _buffer = buffer_create(1024, buffer_grow, 1)
	
	var _index = 1
	
	buffer_seek(_buffer, buffer_seek_start, 0)
	buffer_write(_buffer, buffer_text, "[")
	//
	var _hour = date_get_hour(date_current_datetime())
	if _hour < 10 buffer_write(_buffer, buffer_text, "0")
	buffer_write(_buffer, buffer_text, _hour)
	//
	buffer_write(_buffer, buffer_text, ":")
	if current_minute < 10 buffer_write(_buffer, buffer_text, "0")
	buffer_write(_buffer, buffer_text, current_minute)
	//
	buffer_write(_buffer, buffer_text, ":")
	if current_second < 10 buffer_write(_buffer, buffer_text, "0")
	buffer_write(_buffer, buffer_text, current_second)
	//
	buffer_write(_buffer, buffer_text, ".")
	buffer_write(_buffer, buffer_text, string_pad_zeroes(((current_time % 1000) div 33) * 33, 2))
	buffer_write(_buffer, buffer_text, "] ")
	
	//
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
	
	array_insert(global.log_output, 0, _message)
	array_insert(global.log_color, 0, _color)
	
	if array_length(global.log_output) >= CONSOLE_LOG_CAPACITY {
		array_delete(global.log_output, CONSOLE_LOG_CAPACITY, 1)
		array_delete(global.log_color, CONSOLE_LOG_CAPACITY, 1)
	}
}

function scr_debug_print_stacktrace(_message = undefined, _start = 0) {
	var _trace = debug_get_callstack(99)
	array_pop(_trace)
	array_reverse_ext(_trace)
	
	var _string = string_join_ext("\n|- ", _trace, _start)
	if is_string(_message) {
		print("|---" + string(_message) + "\n|- "+ _string)
	}
	else {
		print("\n|- " + string(_string))
	}
}