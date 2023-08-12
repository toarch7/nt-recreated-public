function scrMakePauseButtons() {
    with UberCont {
		// Settings
        with instance_create(view_xview + view_width - 68, view_yview + view_height - 64, PauseButton)
			image_index = 2
		
		// Continue
        with instance_create(view_xview + view_width - 78, view_yview + view_height - 32, PauseButton)
			image_index = 3
		
		// Menu
        with instance_create(view_xview + 45, view_yview + view_height - 64, PauseButton)
			image_index = 0
		
		// Retry
        if weekly_run or !daily_run {
            with instance_create(view_xview + 60, view_yview + view_height - 32, PauseButton)
				image_index = 1
        }
    }
}