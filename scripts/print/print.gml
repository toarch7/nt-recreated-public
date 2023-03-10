function print() {
    var str = ""

    for (var __arg = 0; __arg < argument_count; __arg++) {
        if __arg {
            str += " "
        }

        str += string(argument[__arg])
    }

    with UberCont {
        array_push(global.log_output, str)
        array_push(global.log_color, c_white)

        if array_length(global.log_output) >= 20 {
            array_delete(global.log_output, 0, 1)
            array_delete(global.log_color, 0, 1)
        }
    }

    show_debug_message(str)

    return str
}