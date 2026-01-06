function scrMakePauseButtons() {
	with UberCont {
		var _left = view_xview,
			_right = _left + view_width,
			_bottom = view_yview + view_height,
			_top_row = _bottom - 64,
			_bottom_row = _bottom - 32
		
		// Menu
        with instance_create(_left + 45, _top_row, PauseButton) {
			image_index = 0
			appear = 1
		}
		
		// Retry
        if !scrGameIsDailyRun() {
            with instance_create(_left + 60, _bottom_row, PauseButton) {
				image_index = 1
				appear = 2
			}
		}
		
		// Settings
        with instance_create(_right - 68, _top_row, PauseButton) {
			image_index = 2
			appear = 3
		}
		
		// Continue
        with instance_create(_right - 78, _bottom_row, PauseButton) {
			image_index = 3
			appear = 3
		}
    }
}