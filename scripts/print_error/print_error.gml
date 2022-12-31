function print_error(text, a = 0) {
    if a or self[$ "_printerror"] == undefined {
        KeyCont.press_paus[global.index] = 1

        show_message_async("Exception handled:\n\n" + text)
        show_debug_message(text)

        if !a {
            self[$ "_printerror"] = 1
        }
    }
}