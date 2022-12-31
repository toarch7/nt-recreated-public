function printc(text, col) {
    array_push(global.log_output, text)
    array_push(global.log_color, col)

    if array_length(global.log_output) >= 20 {
        array_delete(global.log_output, 0, 1)
        array_delete(global.log_color, 0, 1)
    }

    show_debug_message(text)
}