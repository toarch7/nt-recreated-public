function scrWindowOpenSecondary(move = 1) {
    scr_window_set_fullscreen(false)

    if parameter_count() <= 3 {
        window_set_caption("Primary")

        print(parameter_string(0), parameter_string(1), parameter_string(2), parameter_string(3))
		
		execute_shell_simple(parameter_string(0), parameter_string(1) + " " + parameter_string(2) + " " + parameter_string(3) + " -second")

        if move {
            window_set_position(window_get_x() - window_get_width() / 2 - 32, window_get_y())
        }
    } else {
        window_set_caption("Secondary")

        if move {
            window_set_position(window_get_x() + window_get_width() / 2 + 32, window_get_y())
        }
    }

    scr_window_set_fullscreen(false)
	save_set_value("other", "fullscreen", 0)
}