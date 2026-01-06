function scrTime(_nsecs) {
	var _hours = floor(_nsecs / 3600),
		_minutes = floor((_nsecs % 3600) / 60),
		_seconds = floor(_nsecs % 60)
	
	return $"{string_pad_start(_hours, 2, "0")}:{string_pad_start(_minutes, 2, "0")}:{string_pad_start(_seconds, 2, "0")}"
}

function scrTimeSpeedrun(_frames) {
	var _nsecs = _frames / 30,
		_hours = floor(_nsecs / 3600),
		_minutes = floor((_nsecs % 3600) / 60),
		_seconds = floor(_nsecs % 60)
	
	return $"{string_pad_start(_hours, 2, "0")}:{string_pad_start(_minutes, 2, "0")}.{string_pad_start(round(_seconds / 30 * 100), 2, "0")}"
}