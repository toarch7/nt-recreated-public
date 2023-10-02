if async_load[? "id"] == screenshot_image {
	var success = false,
		item = clicked_item
	
	if screenshot_index > 3 or item == undefined or !show_details {
		if sprite_exists(screenshot_image)
			sprite_delete(screenshot_image)
		
		exit
	}
	
	if async_load[? "http_status"] == 200 {
		array_push(screenshots, screenshot_image)
		success = true
	}
	
	if !success {
		screenshot_type ++
		
		if screenshot_type >= array_length(screenshot_formats) {
			screenshot_type = 0
			screenshot_index ++
		}
		
		screenshot_image = self.load_screenshots()
	}
	else {
		screenshot_index ++
		screenshot_type = 0
		
		if screenshot_index <= 3
			screenshot_image = self.load_screenshots()
	}
}